import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/repositories/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'posts_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])

///Tests for PostsRepository methods
void main() async {
  final mockClient = MockHttpClient();
  final postRepo = PostsRepository(mockClient);

  group('Posts Repository tests', () {
    /// Separate group for each method to improve readability
    // Defined json object structure for getPosts method [Post]
    // {"title": String, "id": int}
    group('Get post method tests', () {
      /// Test mapping from http response to app models
      test('Success response', () async {
        // Define success mock response from API
        final successMockResponse = Response(
          requestOptions: RequestOptions(),
          data: [
            {'title': 'Post 1', 'id': 1}
          ],
          statusCode: 200,
        );

        // Define success result of converting to app model
        final expectedResult = [const Post(id: 1, name: 'Post 1')];

        when(mockClient.get('https://jsonplaceholder.typicode.com/posts'))
            .thenAnswer(
          (_) async => successMockResponse,
        );

        final actual = await postRepo.getPosts();

        //Check if actual&expected similar
        expect(actual, expectedResult);
      });

      /// Test behavior if something go wrong
      test('Failure response', () async {
        // Define failure response for this case is null
        final failureMockResponse = Response(
          requestOptions: RequestOptions(
            path: 'https://jsonplaceholder.typicode.com/posts',
          ),
          statusCode: 500,
        );

        when(mockClient.get('https://jsonplaceholder.typicode.com/posts'))
            .thenAnswer((_) async => failureMockResponse);

        final actual = await postRepo.getPosts();

        // Define expected result for handling failure response
        // (for this case its just empty list)
        final expectedResult = [];

        expect(actual, expectedResult);
      });
    });
  });
}
