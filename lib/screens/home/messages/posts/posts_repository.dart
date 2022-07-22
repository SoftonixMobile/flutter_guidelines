import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/services/http/http_client.dart';
import 'models/models.dart';

@injectable
class PostsRepository {
  PostsRepository(this.httpClient);

  final HttpClient httpClient;

  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      10,
      (index) => Post(id: index, name: 'Post $index'),
    );
  }
}
