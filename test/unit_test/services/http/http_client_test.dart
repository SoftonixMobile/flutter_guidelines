import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/services/index.dart';

class MockDio extends Mock implements Dio {}

class MockFresh extends Mock implements Fresh<String> {}

class MockInterceptors extends Mock implements Interceptors {}

// Tests for HttpClient methods
void main() async {
  late final Dio mockDio;
  late final Fresh<String> mockFresh;

  late HttpClient httpClient;

  setUp(() {
    mockDio = MockDio();
    mockFresh = MockFresh();

    when(() => mockDio.interceptors).thenReturn(MockInterceptors());

    httpClient = HttpClient(
      dio: mockDio,
      fresh: mockFresh,
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
        final actual = await httpClient.get<List<Post>>('/posts');

        // Check if actual & expected are equal
        expect(actual, [const Post(id: 1, name: 'Post 1')]);

        verify(() => mockDio.get('/posts')).called(1);
      });
    });
  });
}
