import 'package:data_provider/models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_guidelines/core/logger/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';

class MockDio extends Mock implements Dio {}

class MockFresh extends Mock implements Fresh<String> {}

class MockLogger extends Mock implements Logger {}

class MockInterceptors extends Mock implements Interceptors {}

// Tests for HttpClient methods
void main() async {
  late final Dio mockDio;
  late final Fresh<String> mockFresh;
  late final Logger mockLogger;

  late HttpClient httpClient;

  setUp(() {
    mockDio = MockDio();
    mockFresh = MockFresh();
    mockLogger = MockLogger();

    when(() => mockDio.interceptors).thenReturn(MockInterceptors());

    httpClient = HttpClient(
      dio: mockDio,
      fresh: mockFresh,
      logger: mockLogger,
    );
  });

  group('HttpClient tests', () {
    // Separate group for each method to improve readability
    group('Get method tests', () {
      test('Success mapping response to the model', () async {
        // Define success mock response from API
        final successMockResponse = Response(
          requestOptions: RequestOptions(),
          data: [
            {'title': 'Post 1', 'id': 1},
          ],
          statusCode: 200,
        );

        when(
          () => mockDio.get('/posts'),
        ).thenAnswer(
          (_) async => successMockResponse,
        );

        httpClient.registerType(Post.fromJson);
        final actual = await httpClient.getData<List<Post>>('/posts');

        // Check if actual & expected are equal
        expect(actual, [const Post(id: 1, name: 'Post 1')]);

        verify(() => mockDio.get('/posts')).called(1);
      });
    });
  });
}
