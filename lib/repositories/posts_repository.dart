import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/services/http/http_client.dart';

@injectable
class PostsRepository {
  final HttpClient httpClient;

  PostsRepository(this.httpClient);

  Future<List<Post>> getPosts() =>
      httpClient.get<List<Post>>('https://jsonplaceholder.typicode.com/posts');
}
