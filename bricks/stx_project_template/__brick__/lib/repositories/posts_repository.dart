import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/services/http/http_client.dart';

@injectable
class PostsRepository {
  final HttpClient httpClient;

  PostsRepository(this.httpClient);

  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      100,
      (index) => Post(id: index, name: 'Post $index'),
    );
  }
}
