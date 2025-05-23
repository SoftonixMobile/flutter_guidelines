import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/repositories/index.dart';

@lazySingleton
class PostsBloc extends NetworkListBloc<Post, NetworkListState<Post>> {
  final PostsRepository postsRepository;

  PostsBloc({
    required this.postsRepository,
  }) : super(const NetworkListState(data: []));

  @override
  Future<List<Post>> onLoadAsync() {
    return postsRepository.getPosts();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
