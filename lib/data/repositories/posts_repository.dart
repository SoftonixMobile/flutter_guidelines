import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';

@injectable
class PostsRepository {
  final HttpClient _httpClient;

  PostsRepository(this._httpClient) {
    _httpClient.registerType<Post>(Post.fromJson);
  }

  Future<List<Post>> getPosts() =>
      _httpClient.get<List<Post>>('https://jsonplaceholder.typicode.com/posts');
}
