import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/services/http/index.dart';

@injectable
class PostsRepository {
  final HttpClient httpClient;

  PostsRepository(this.httpClient) {
    httpClient.registerType<Post>(Post.fromJson);
  }

  Future<List<Post>> getPosts() =>
      httpClient.get<List<Post>>('https://jsonplaceholder.typicode.com/posts');
}
