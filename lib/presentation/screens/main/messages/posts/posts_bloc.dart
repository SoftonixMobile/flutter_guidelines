import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

typedef PostsState = NetworkListState<Post>;

@injectable
class PostsBloc(final PostsRepository _postsRepository)
    extends NetworkListBloc<Post, PostsState> {
  this : super(const NetworkListState(data: []));

  @override
  FutureOr<List<Post>> onLazyLoad() {
    return _postsRepository.getPosts();
  }

  @override
  Future<List<Post>> onLoadAsync() async {
    return await _postsRepository.getPosts(refresh: true);
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
