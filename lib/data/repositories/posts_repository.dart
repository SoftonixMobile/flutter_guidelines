import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

import 'package:flutter_guidelines/data/mappers/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

@lazySingleton
class PostsRepository(final PostsService _postsService)
    extends ListRepositoryBase<Post>
    with DisposableRepositoryMixin, StreamRepositoryMixin {
  FutureOr<List<Post>> getPosts({bool refresh = false}) {
    return load(_fetchPosts, refresh: refresh);
  }

  Future<Post> createPost(Post post) async {
    final response = await _postsService.createPost(post.toDto());

    return emitItem(response.toDomain());
  }

  Future<Post> updatePost(Post post) async {
    final response = await _postsService.updatePost(post.toDto());

    return emitItem(response.toDomain());
  }

  Future<List<Post>> _fetchPosts() async {
    final response = await _postsService.getAllPosts();

    return response.map((post) => post.toDomain()).toList();
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
