import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PostsRepository extends Cubit<List<Post>> {
  final PostsService _postsService;

  PostsRepository(this._postsService) : super([]);

  Future<List<Post>> getPosts() async {
    final posts = await _postsService.getPosts();

    emit(posts);

    return posts;
  }

  @override
  @disposeMethod
  Future<void> close() {
    return super.close();
  }
}
