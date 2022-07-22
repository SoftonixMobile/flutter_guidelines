import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'posts_repository.dart';

@injectable
class PostsBloc extends NetworkListBloc<Post, NetworkListState<Post>> {
  PostsBloc(this.repository) : super(NetworkListState());

  final PostsRepository repository;

  @override
  Future<List<Post>> onLoadDataAsync() {
    return repository.getPosts();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.name == item2.name;
  }
}
