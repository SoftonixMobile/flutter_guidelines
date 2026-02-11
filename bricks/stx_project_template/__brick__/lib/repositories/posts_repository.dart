import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/services/index.dart';

@injectable
class PostsRepository {
  final HttpClient _httpClient;

  PostsRepository(this._httpClient) {
    _httpClient.registerType<Post>(Post.fromJson);
  }

  Future<List<Post>> getPosts() =>
      _httpClient.get<List<Post>>('https://jsonplaceholder.typicode.com/posts');
}
