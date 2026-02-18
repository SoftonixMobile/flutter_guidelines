import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

@lazySingleton
class PostsRepository extends ListRepositoryBase<Post> {
  final PostsService _postsService;

  PostsRepository(this._postsService);

  Future<List<Post>> getPosts() {
    return load(_postsService.getPosts);
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
