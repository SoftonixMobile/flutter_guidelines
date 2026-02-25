import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

@lazySingleton
class PostsRepository extends ListRepositoryBase<Post>
    with DisposableRepositoryMixin, StreamRepositoryMixin {
  final PostsService _postsService;

  PostsRepository(this._postsService);

  FutureOr<List<Post>> getPosts({bool refreshData = false}) {
    return load(_postsService.getAllPosts, refresh: refreshData);
  }

  Future<Post> createPost(Post post) async {
    final response = await _postsService.createPost(post);

    return emitItem(response);
  }

  Future<Post> updatePost(Post post) async {
    final response = await _postsService.updatePost(post);

    return emitItem(response);
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }

  @override
  @disposeMethod
  Future<void> close() {
    return super.close();
  }
}
