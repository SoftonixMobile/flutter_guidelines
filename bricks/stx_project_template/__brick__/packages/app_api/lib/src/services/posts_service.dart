import 'package:api_client/api_client.dart';
import 'package:app_api/models.dart';
import 'package:injectable/injectable.dart';

@injectable
class PostsService(final ApiClient _client) {
  this {
    _client.registerType(PostDto.fromJson);
  }

  Future<List<PostDto>> getAllPosts() {
    return _client.getData<List<PostDto>>(
      'https://jsonplaceholder.typicode.com/posts',
    );
  }

  Future<PostDto> createPost(PostDto post) {
    return Future.delayed(Duration(seconds: 1), () => post);
  }

  Future<PostDto> updatePost(PostDto post) {
    return Future.delayed(Duration(seconds: 1), () => post);
  }
}
