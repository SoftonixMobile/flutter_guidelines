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

  DioAuthSession createSession() =>
      DioAuthSession(storage: storage, bareClient: dio.Dio());

  DioApiClient createClient(DioAuthSession session) {
    final httpClient = dio.Dio(dio.BaseOptions(baseUrl: _baseUrl))
      ..httpClientAdapter = adapter;

    return DioApiClient(
      baseUrl: _baseUrl,
      authSession: session,
      httpClient: httpClient,
    );
  }

  void storeToken(AuthToken token) =>
      storage.values[_tokenKey] = jsonEncode(token.toJson());

  Future<AuthStatus> resolvedStatus(AuthSession session) =>
      session.onStatusChanged.firstWhere((status) => status != .initial);

  setUp(() {
    storage = InMemoryStorage();
    adapter = FakeAdapter();
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
  });
}
