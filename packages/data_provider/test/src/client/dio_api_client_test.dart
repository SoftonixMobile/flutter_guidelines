import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:dio/dio.dart' as dio;
import 'package:storage/storage.dart';
import 'package:test/test.dart';

const _baseUrl = 'https://api.test';

/// Key used by `SecureTokenStorage`.
const _tokenKey = 'auth_token';

class _InMemoryStorage() implements Storage {
  final values = <String, String>{};

  @override
  Future<String?> read({required String key}) async => values[key];

  @override
  Future<void> write({required String key, required String value}) async =>
      values[key] = value;

  @override
  Future<void> delete({required String key}) async => values.remove(key);
}

/// Records every request and replies with [statusCode] and [body].
class _FakeAdapter() implements dio.HttpClientAdapter {
  final requests = <dio.RequestOptions>[];

  int statusCode = 200;
  Object? body = <String, dynamic>{};

  dio.RequestOptions get lastRequest => requests.last;

  @override
  Future<dio.ResponseBody> fetch(
    dio.RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);

    return dio.ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      statusMessage: 'status $statusCode',
      headers: {
        dio.Headers.contentTypeHeader: [dio.Headers.jsonContentType],
        'x-test': ['value'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _jwt({required DateTime expiresAt}) {
  String encode(Map<String, dynamic> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');

  final header = encode({'alg': 'HS256', 'typ': 'JWT'});
  final payload = encode({'exp': expiresAt.millisecondsSinceEpoch ~/ 1000});

  return '$header.$payload.signature';
}

void main() {
  late _InMemoryStorage storage;
  late _FakeAdapter adapter;

  DioApiClient createClient() {
    final httpClient = dio.Dio(dio.BaseOptions(baseUrl: _baseUrl))
      ..httpClientAdapter = adapter;

    return DioApiClient(
      baseUrl: _baseUrl,
      storage: storage,
      httpClient: httpClient,
      bareClient: dio.Dio(),
    );
  }

  void storeToken(TokenResponse token) =>
      storage.values[_tokenKey] = jsonEncode(token.toJson());

  Future<AuthStatus> resolvedStatus(DioApiClient client) =>
      client.onSessionStatusChanged.firstWhere((status) => status != .initial);

  setUp(() {
    storage = _InMemoryStorage();
    adapter = _FakeAdapter();
  });

  group('DioApiClient', () {
    group('requests', () {
      test('get sends a GET request with query parameters', () async {
        final client = createClient();

        await client.get<dynamic>('/posts', queryParameters: {'page': 2});

        expect(adapter.lastRequest.method, 'GET');
        expect(adapter.lastRequest.uri.toString(), '$_baseUrl/posts?page=2');
      });

      test('post, put and patch send the method and body', () async {
        final client = createClient();
        final body = {'title': 'Post'};

        await client.post<dynamic>('/posts', data: body);
        expect(adapter.lastRequest.method, 'POST');
        expect(adapter.lastRequest.data, body);

        await client.put<dynamic>('/posts/1', data: body);
        expect(adapter.lastRequest.method, 'PUT');
        expect(adapter.lastRequest.data, body);

        await client.patch<dynamic>('/posts/1', data: body);
        expect(adapter.lastRequest.method, 'PATCH');
        expect(adapter.lastRequest.data, body);
      });

      test('delete sends a DELETE request', () async {
        final client = createClient();

        await client.delete<dynamic>('/posts/1');

        expect(adapter.lastRequest.method, 'DELETE');
        expect(adapter.lastRequest.path, '/posts/1');
      });

      test('passes RequestOptions to the request', () async {
        final client = createClient();

        await client.get<dynamic>(
          '/posts',
          options: RequestOptions(
            headers: {'x-custom': 'custom'},
            extra: {'key': 'value'},
            contentType: 'text/plain',
          ),
        );

        expect(adapter.lastRequest.headers['x-custom'], 'custom');
        expect(adapter.lastRequest.extra['key'], 'value');
        expect(adapter.lastRequest.contentType, 'text/plain');
      });
    });

    group('responses', () {
      test('parses data into a registered type', () async {
        final client = createClient()..registerType(TokenResponse.fromJson);
        adapter.body = {'accessToken': 'access', 'refreshToken': 'refresh'};

        final response = await client.get<TokenResponse>('/token');

        expect(
          response.data,
          const TokenResponse(accessToken: 'access', refreshToken: 'refresh'),
        );
      });

      test('parses a list of a registered type', () async {
        final client = createClient()..registerType(TokenResponse.fromJson);
        adapter.body = [
          {'accessToken': 'a1', 'refreshToken': 'r1'},
          {'accessToken': 'a2', 'refreshToken': 'r2'},
        ];

        final data = await client.getData<List<TokenResponse>>('/tokens');

        expect(data, const [
          TokenResponse(accessToken: 'a1', refreshToken: 'r1'),
          TokenResponse(accessToken: 'a2', refreshToken: 'r2'),
        ]);
      });

      test('returns raw data for an unregistered type', () async {
        final client = createClient();
        adapter.body = {'id': 1};

        final data = await client.getData<Map<String, dynamic>>('/raw');

        expect(data, {'id': 1});
      });

      test('maps status code, status message and headers', () async {
        final client = createClient();
        adapter.statusCode = 201;

        final response = await client.post<dynamic>('/posts');

        expect(response.statusCode, 201);
        expect(response.statusMessage, 'status 201');
        expect(response.headers['x-test'], ['value']);
      });

      test('throws an ApiException on an error status code', () async {
        final client = createClient();
        adapter
          ..statusCode = 404
          ..body = {'message': 'Post not found'};

        await expectLater(
          client.get<dynamic>('/posts/1'),
          throwsA(
            isA<ApiException>()
                .having((e) => e.type, 'type', ApiExceptionType.notFound)
                .having((e) => e.statusCode, 'statusCode', 404)
                .having((e) => e.message, 'message', 'Post not found'),
          ),
        );
      });

      test('download writes the response to the path', () async {
        final client = createClient();
        final directory = await Directory.systemTemp.createTemp();
        addTearDown(() => directory.delete(recursive: true));
        final path = '${directory.path}/file.json';
        adapter.body = {'id': 1};

        final response = await client.download('/file', path);

        expect(response.statusCode, 200);
        expect(await File(path).readAsString(), jsonEncode({'id': 1}));
      });
    });

    group('session', () {
      test('is unauthenticated when no token is stored', () async {
        final client = createClient();

        expect(await resolvedStatus(client), AuthStatus.unauthenticated);
      });

      test('is authenticated when a token is stored', () async {
        storeToken(
          const TokenResponse(accessToken: 'access', refreshToken: 'refresh'),
        );
        final client = createClient();

        expect(await resolvedStatus(client), AuthStatus.authenticated);
      });

      test('sends no Authorization header without a session', () async {
        final client = createClient();

        await client.get<dynamic>('/posts');

        expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
      });

      test('startSession stores the token and authenticates', () async {
        final client = createClient();
        const token = TokenResponse(
          accessToken: 'access',
          refreshToken: 'refresh',
        );

        await client.startSession(token);
        await client.get<dynamic>('/posts');

        expect(await resolvedStatus(client), AuthStatus.authenticated);
        expect(storage.values[_tokenKey], jsonEncode(token.toJson()));
        expect(adapter.lastRequest.headers['Authorization'], 'Bearer access');
      });

      test('clearSession deletes the token and unauthenticates', () async {
        storeToken(
          const TokenResponse(accessToken: 'access', refreshToken: 'refresh'),
        );
        final client = createClient();
        await resolvedStatus(client);

        await client.clearSession();
        await client.get<dynamic>('/posts');

        expect(await resolvedStatus(client), AuthStatus.unauthenticated);
        expect(storage.values, isNot(contains(_tokenKey)));
        expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
      });

      test('sends a JWT that is not expired', () async {
        final accessToken = _jwt(
          expiresAt: DateTime.now().add(const Duration(hours: 1)),
        );
        storeToken(TokenResponse(accessToken: accessToken, refreshToken: 'r'));
        final client = createClient();

        await client.get<dynamic>('/posts');

        expect(
          adapter.lastRequest.headers['Authorization'],
          'Bearer $accessToken',
        );
        expect(await resolvedStatus(client), AuthStatus.authenticated);
      });

      test('ends the session before sending an expired JWT', () async {
        final accessToken = _jwt(
          expiresAt: DateTime.now().subtract(const Duration(minutes: 1)),
        );
        storeToken(TokenResponse(accessToken: accessToken, refreshToken: 'r'));
        final client = createClient();

        await client.get<dynamic>('/posts');

        expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
        expect(await resolvedStatus(client), AuthStatus.unauthenticated);
        expect(storage.values, isNot(contains(_tokenKey)));
      });

      test('ends the session when a JWT expires within 30 seconds', () async {
        final accessToken = _jwt(
          expiresAt: DateTime.now().add(const Duration(seconds: 10)),
        );
        storeToken(TokenResponse(accessToken: accessToken, refreshToken: 'r'));
        final client = createClient();

        await client.get<dynamic>('/posts');

        expect(adapter.lastRequest.headers, isNot(contains('Authorization')));
        expect(await resolvedStatus(client), AuthStatus.unauthenticated);
      });
    });
  });
}
