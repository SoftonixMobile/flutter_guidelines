import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'posts_repository.dart';

@lazySingleton
class PostsBloc extends NetworkListBloc<Post, NetworkListState<Post>> {
  PostsBloc(this.repository) : super(const NetworkListState(data: []));

  final PostsRepository repository;

  @override
  Future<List<Post>> onLoadAsync() {
    return repository.getPosts();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
