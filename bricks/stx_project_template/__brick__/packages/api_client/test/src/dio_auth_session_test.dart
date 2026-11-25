import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart' as dio;
import 'package:test/test.dart';

import '../helpers/fakes.dart';

const _baseUrl = 'https://api.test';

/// Key used by `SecureTokenStorage`.
const _tokenKey = 'auth_token';

String _jwt({required DateTime expiresAt}) {
  String encode(Map<String, dynamic> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');

  final header = encode({'alg': 'HS256', 'typ': 'JWT'});
  final payload = encode({'exp': expiresAt.millisecondsSinceEpoch ~/ 1000});

  return '$header.$payload.signature';
}

void main() {
  late InMemoryStorage storage;
  late FakeAdapter adapter;
  late FakeAdapter bareAdapter;

  DioAuthSession createSession({TokenRefresher? tokenRefresher}) {
    final bareClient = dio.Dio()..httpClientAdapter = bareAdapter;

    return DioAuthSession(
      baseUrl: _baseUrl,
      storage: storage,
      tokenRefresher: tokenRefresher,
      httpClient: bareClient,
    );
  }

  DioApiClient createClient(
    DioAuthSession session, {
    String baseUrl = _baseUrl,
  }) {
    final httpClient = dio.Dio(dio.BaseOptions(baseUrl: baseUrl))
      ..httpClientAdapter = adapter;

    return DioApiClient(
      baseUrl: baseUrl,
      authSession: session,
      httpClient: httpClient,
    );
  }

  void storeToken(AuthToken token) =>
      storage.values[_tokenKey] = jsonEncode(token.toJson());

  Future<AuthStatus> resolvedStatus(AuthSession session) =>
      session.onStatusChanged.firstWhere((status) => status != .initial);

  final throwsUnauthorized = throwsA(
    isA<ApiException>()
        .having((e) => e.type, 'type', ApiExceptionType.unauthorized)
        .having((e) => e.statusCode, 'statusCode', 401),
  );

  setUp(() {
    storage = InMemoryStorage();
    adapter = FakeAdapter();
    bareAdapter = FakeAdapter();
  });

  group('DioAuthSession', () {
    test('is unauthenticated when no token is stored', () async {
      final session = createSession();

      expect(session.status, AuthStatus.initial);
      expect(await resolvedStatus(session), AuthStatus.unauthenticated);
      expect(session.status, AuthStatus.unauthenticated);
    });

    test('is authenticated when a token is stored', () async {
      storeToken(
        const AuthToken(accessToken: 'access', refreshToken: 'refresh'),
      );
      final session = createSession();

      expect(await resolvedStatus(session), AuthStatus.authenticated);
      expect(session.status, AuthStatus.authenticated);
    });

    test('sends no Authorization header when unauthenticated', () async {
      final client = createClient(createSession());

      await client.get<dynamic>('/posts');

      expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
    });

    test('start stores the token and authenticates', () async {
      final session = createSession();
      final client = createClient(session);
      const token = AuthToken(
        accessToken: 'access',
        refreshToken: 'refresh',
      );

      await session.start(token);
      await client.get<dynamic>('/posts');

      expect(session.status, AuthStatus.authenticated);
      expect(await resolvedStatus(session), AuthStatus.authenticated);
      expect(storage.values[_tokenKey], jsonEncode(token.toJson()));
      expect(adapter.lastRequest.headers['Authorization'], 'Bearer access');
    });

    test('clear deletes the token and unauthenticates', () async {
      storeToken(
        const AuthToken(accessToken: 'access', refreshToken: 'refresh'),
      );
      final session = createSession();
      final client = createClient(session);
      await resolvedStatus(session);

      await session.clear();
      await client.get<dynamic>('/posts');

      expect(session.status, AuthStatus.unauthenticated);
      expect(await resolvedStatus(session), AuthStatus.unauthenticated);
      expect(storage.values, isNot(contains(_tokenKey)));
      expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
    });

    test('sends a JWT that is not expired', () async {
      final accessToken = _jwt(
        expiresAt: DateTime.now().add(const Duration(hours: 1)),
      );
      storeToken(AuthToken(accessToken: accessToken, refreshToken: 'r'));
      final session = createSession();
      final client = createClient(session);

      await client.get<dynamic>('/posts');

      expect(
        adapter.lastRequest.headers['Authorization'],
        'Bearer $accessToken',
      );
      expect(await resolvedStatus(session), AuthStatus.authenticated);
    });

    test('ends the session before sending an expired JWT', () async {
      final accessToken = _jwt(
        expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
      );
      storeToken(AuthToken(accessToken: accessToken, refreshToken: 'r'));
      final session = createSession();
      final client = createClient(session);

      await client.get<dynamic>('/posts');

      expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
      expect(await resolvedStatus(session), AuthStatus.unauthenticated);
      expect(storage.values, isNot(contains(_tokenKey)));
    });

    test('ends the session when a JWT expires within 30 seconds', () async {
      final accessToken = _jwt(
        expiresAt: DateTime.now().add(const Duration(seconds: 10)),
      );
      storeToken(AuthToken(accessToken: accessToken, refreshToken: 'r'));
      final session = createSession();
      final client = createClient(session);

      await client.get<dynamic>('/posts');

      expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
      expect(await resolvedStatus(session), AuthStatus.unauthenticated);
    });

    test('ends the session when the server returns a 401', () async {
      storeToken(
        const AuthToken(accessToken: 'access', refreshToken: 'refresh'),
      );
      adapter.statusCode = 401;
      final session = createSession();
      final client = createClient(session);

      await expectLater(client.get<dynamic>('/posts'), throwsUnauthorized);

      expect(await resolvedStatus(session), AuthStatus.unauthenticated);
      expect(storage.values, isNot(contains(_tokenKey)));
    });

    group('with a token refresher', () {
      const token = AuthToken(accessToken: 'access', refreshToken: 'refresh');
      const refreshed = AuthToken(
        accessToken: 'new-access',
        refreshToken: 'new-refresh',
      );

      AuthToken storeExpiredToken() {
        final expired = AuthToken(
          accessToken: _jwt(
            expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
          ),
          refreshToken: 'refresh',
        );
        storeToken(expired);

        return expired;
      }

      Future<AuthToken> rejected(AuthToken _, ApiClient _) async =>
          throw const ApiException(type: .unauthorized, statusCode: 401);

      Future<AuthToken> offline(AuthToken _, ApiClient _) async =>
          throw const ApiException(type: .noConnection);

      final throwsNoConnection = throwsA(
        isA<ApiException>().having(
          (e) => e.type,
          'type',
          ApiExceptionType.noConnection,
        ),
      );

      test('refreshes an expired JWT before sending the request', () async {
        final expired = storeExpiredToken();
        final refreshedTokens = <AuthToken>[];
        final session = createSession(
          tokenRefresher: (token, _) async {
            refreshedTokens.add(token);

            return refreshed;
          },
        );
        final client = createClient(session);

        await client.get<dynamic>('/posts');

        expect(refreshedTokens, [expired]);
        expect(
          adapter.lastRequest.headers['Authorization'],
          'Bearer new-access',
        );
        expect(storage.values[_tokenKey], jsonEncode(refreshed.toJson()));
        expect(await resolvedStatus(session), AuthStatus.authenticated);
      });

      test('refreshes the token and retries the request on a 401', () async {
        storeToken(token);
        adapter.statusCode = 401;
        bareAdapter.body = {'id': 1};
        final session = createSession(
          tokenRefresher: (_, _) async => refreshed,
        );
        final client = createClient(session);

        final data = await client.getData<Map<String, dynamic>>('/posts');

        expect(data, {'id': 1});
        expect(bareAdapter.lastRequest.uri.toString(), '$_baseUrl/posts');
        expect(
          bareAdapter.lastRequest.headers['Authorization'],
          'Bearer new-access',
        );
        expect(storage.values[_tokenKey], jsonEncode(refreshed.toJson()));
      });

      test('gives the refresher a client without the session', () async {
        storeExpiredToken();
        final session = createSession(
          tokenRefresher: (token, client) async {
            await client.post<dynamic>(
              '/auth/refresh',
              data: {'refreshToken': token.refreshToken},
            );

            return refreshed;
          },
        );
        final client = createClient(session);

        await client.get<dynamic>('/posts');

        final request = bareAdapter.lastRequest;
        expect(request.uri.toString(), '$_baseUrl/auth/refresh');
        expect(request.data, {'refreshToken': 'refresh'});
        expect(request.headers, isNot(contains('Authorization')));
      });

      test('ends the session when the refresh is rejected', () async {
        storeExpiredToken();
        final session = createSession(tokenRefresher: rejected);
        final client = createClient(session);

        await client.get<dynamic>('/posts');

        expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
        expect(await resolvedStatus(session), AuthStatus.unauthenticated);
        expect(storage.values, isNot(contains(_tokenKey)));
      });

      test(
        'ends the session when the refresh after a 401 is rejected',
        () async {
          storeToken(token);
          adapter.statusCode = 401;
          final session = createSession(tokenRefresher: rejected);
          final client = createClient(session);

          await expectLater(client.get<dynamic>('/posts'), throwsUnauthorized);

          expect(await resolvedStatus(session), AuthStatus.unauthenticated);
          expect(storage.values, isNot(contains(_tokenKey)));
        },
      );

      test('keeps the session when the refresh fails', () async {
        storeExpiredToken();
        final session = createSession(tokenRefresher: offline);
        final client = createClient(session);

        await expectLater(client.get<dynamic>('/posts'), throwsNoConnection);

        expect(adapter.requests, isEmpty);
        expect(await resolvedStatus(session), AuthStatus.authenticated);
        expect(storage.values, contains(_tokenKey));
      });

      test('keeps the session when the refresh after a 401 fails', () async {
        storeToken(token);
        adapter.statusCode = 401;
        final session = createSession(tokenRefresher: offline);
        final client = createClient(session);

        await expectLater(client.get<dynamic>('/posts'), throwsNoConnection);

        expect(bareAdapter.requests, isEmpty);
        expect(await resolvedStatus(session), AuthStatus.authenticated);
        expect(storage.values, contains(_tokenKey));
      });

      test('fails the request when the refresher throws any error', () async {
        storeToken(token);
        adapter.statusCode = 401;
        final session = createSession(
          tokenRefresher: (_, _) async => throw StateError('boom'),
        );
        final client = createClient(session);

        await expectLater(
          client.get<dynamic>('/posts'),
          throwsA(
            isA<ApiException>()
                .having((e) => e.type, 'type', ApiExceptionType.unknown)
                .having((e) => e.error, 'error', isStateError),
          ),
        );

        expect(await resolvedStatus(session), AuthStatus.authenticated);
      });
    });

    test('authorizes every client it is passed to', () async {
      final session = createSession();
      final first = createClient(session);
      final second = createClient(session);
      await session.start(
        const AuthToken(accessToken: 'access', refreshToken: 'refresh'),
      );

      await first.get<dynamic>('/posts');
      await second.get<dynamic>('/chats');

      expect(
        adapter.requests.map((request) => request.headers['Authorization']),
        ['Bearer access', 'Bearer access'],
      );
    });

    group('requests to another origin', () {
      const token = AuthToken(accessToken: 'access', refreshToken: 'refresh');

      test('are sent without the Authorization header', () async {
        storeToken(token);
        final client = createClient(createSession());

        for (final url in [
          'https://other.test/posts',
          'http://api.test/posts',
          'https://api.test:8443/posts',
        ]) {
          await client.get<dynamic>(url);

          expect(adapter.lastRequest.uri.toString(), url);
          expect(
            adapter.lastRequest.headers,
            isNot(contains('Authorization')),
            reason: url,
          );
        }
      });

      test('keep the session on a 401', () async {
        storeToken(token);
        adapter.statusCode = 401;
        final session = createSession();
        final client = createClient(session);

        await expectLater(
          client.get<dynamic>('https://other.test/posts'),
          throwsUnauthorized,
        );

        expect(await resolvedStatus(session), AuthStatus.authenticated);
        expect(storage.values, contains(_tokenKey));
      });

      test('are told apart by the base URL of each client', () async {
        storeToken(token);
        final client = createClient(
          createSession(),
          baseUrl: 'https://other.test',
        );

        await client.get<dynamic>('/posts');
        await client.get<dynamic>('$_baseUrl/posts');

        expect(
          adapter.requests.map((request) => request.headers['Authorization']),
          ['Bearer access', null],
        );
      });
    });
  });
}
