import 'dart:async';

import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

@lazySingleton
class PostsRepository extends ListRepositoryBase<Post>
    with DisposableRepositoryMixin, StreamRepositoryMixin {
  final PostsService _postsService;

  PostsRepository(this._postsService);

  Future<List<Post>> getPosts({bool forceRefresh = false}) {
    return load(_postsService.getAll, forceDataRefresh: forceRefresh);
  }

  Future<Post> createPost(Post post) async {
    final response = await _postsService.create(post);

    final updatedPosts = [...data, response];
    emit(updatedPosts);

    return response;
  }

  Future<Post> updatePost(Post post) async {
    final response = await _postsService.update(post);

    replaceItem(response);

    return response;
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
