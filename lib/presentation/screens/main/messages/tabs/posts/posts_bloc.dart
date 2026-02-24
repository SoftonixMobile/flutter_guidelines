import 'dart:async';

import 'package:data_provider/models.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/data/repositories/index.dart';

typedef PostsState = NetworkListState<Post>;

@injectable
class PostsBloc extends NetworkListBloc<Post, PostsState> {
  final PostsRepository _postsRepository;

  PostsBloc(this._postsRepository) : super(const NetworkListState(data: []));

  @override
  FutureOr<List<Post>> onLazyLoad() {
    return _postsRepository.getPosts();
  }

  @override
  Future<List<Post>> onLoadAsync() async {
    return _postsRepository.getPosts(refreshData: true);
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
