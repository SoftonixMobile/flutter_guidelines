import 'package:injectable/injectable.dart';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';

@injectable
class PostsService {
  final ApiClient _client;

  PostsService(this._client) {
    _client.registerType(Post.fromJson);
  }

  Future<List<Post>> getAllPosts() async {
    return _client.getData<List<Post>>(
      'https://jsonplaceholder.typicode.com/posts',
    );
  }

  Future<Post> createPost(Post post) {
    return Future.delayed(Duration(seconds: 1), () => post);
  }

  Future<Post> updatePost(Post post) {
    return Future.delayed(Duration(seconds: 1), () => post);
  }
}
