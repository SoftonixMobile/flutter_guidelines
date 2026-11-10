import 'dart:convert';
import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart' as dio;
import 'package:test/test.dart';

import '../helpers/fakes.dart';

const _baseUrl = 'https://api.test';

void main() {
  late FakeAdapter adapter;

  DioApiClient createClient() {
    final httpClient = dio.Dio(dio.BaseOptions(baseUrl: _baseUrl))
      ..httpClientAdapter = adapter;

    return DioApiClient(baseUrl: _baseUrl, httpClient: httpClient);
  }

  setUp(() {
    adapter = FakeAdapter();
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
        final client = createClient()..registerType(AuthToken.fromJson);
        adapter.body = {'accessToken': 'access', 'refreshToken': 'refresh'};

        final response = await client.get<AuthToken>('/token');

        expect(
          response.data,
          const AuthToken(accessToken: 'access', refreshToken: 'refresh'),
        );
      });

      test('parses a list of a registered type', () async {
        final client = createClient()..registerType(AuthToken.fromJson);
        adapter.body = [
          {'accessToken': 'a1', 'refreshToken': 'r1'},
          {'accessToken': 'a2', 'refreshToken': 'r2'},
        ];

        final data = await client.getData<List<AuthToken>>('/tokens');

        expect(data, const [
          AuthToken(accessToken: 'a1', refreshToken: 'r1'),
          AuthToken(accessToken: 'a2', refreshToken: 'r2'),
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
  });
}
