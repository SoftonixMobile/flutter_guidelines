import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/services/http/http_client.dart';
import 'models/models.dart';

@injectable
class PostsRepository {
  PostsRepository(this.httpClient);

  final HttpClient httpClient;

  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      100,
      (index) => Post(id: index, name: 'Post $index'),
    );
  }
}
