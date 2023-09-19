import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/services/http/http_client.dart';

@injectable
class PostsRepository {
  final HttpClient httpClient;

  PostsRepository(this.httpClient);

  Future<List<Post>> getPosts() async {
    final response =
        await httpClient.get('https://jsonplaceholder.typicode.com/posts');

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Post.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
