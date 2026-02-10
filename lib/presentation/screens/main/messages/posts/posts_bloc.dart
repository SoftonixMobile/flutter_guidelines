import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/data/repositories/index.dart';

typedef PostsState = NetworkListState<Post>;

@lazySingleton
class PostsBloc extends NetworkListBloc<Post, PostsState> {
  final PostsRepository _postsRepository;

  PostsBloc(this._postsRepository) : super(const NetworkListState(data: []));

  @override
  Future<List<Post>> onLoadAsync() {
    return _postsRepository.getPosts();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
