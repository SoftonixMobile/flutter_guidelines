import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/services/http/http_client.dart';

@injectable
class PostsRepository {
  final HttpClient httpClient;

  PostsRepository(this.httpClient);

  Future<List<Post>> getPosts() =>
      httpClient.get<List<Post>>('https://jsonplaceholder.typicode.com/posts');
}
