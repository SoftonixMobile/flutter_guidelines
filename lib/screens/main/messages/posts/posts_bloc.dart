import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/repositories/index.dart';

typedef PostsState = NetworkListState<Post>;

@lazySingleton
class PostsBloc(final PostsRepository _postsRepository)
    extends NetworkListBloc<Post, PostsState> {
  this : super(const NetworkListState(data: []));

  @override
  Future<List<Post>> onLoadAsync() {
    return _postsRepository.getPosts();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
