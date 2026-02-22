import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_repository/stx_repository.dart';

@lazySingleton
class PostsRepository extends ListRepositoryBase<Post>
    with DisposableRepositoryMixin, StreamRepositoryMixin {
  final PostsService _postsService;

  PostsRepository(this._postsService);

  Future<List<Post>> getPosts({bool forceRefresh = false}) {
    return load(_postsService.getAllPosts, refresh: forceRefresh);
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
