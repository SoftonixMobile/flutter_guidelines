import 'dart:async';

import 'package:data_provider/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/data/repositories/index.dart';

typedef DrawerState = NetworkListState<Post>;

@injectable
class DrawerBloc extends NetworkListBloc<Post, DrawerState> {
  final PostsRepository _postsRepository;

  late final StreamSubscription<List<Post>> _postsSubscription;

  DrawerBloc(this._postsRepository)
    : super(
        const DrawerState(
          data: [],
        ),
      ) {
    _postsSubscription = _postsRepository.stream.listen((data) {
      final updatedData = _filterPosts(data);

      if (!const DeepCollectionEquality.unordered().equals(
        updatedData,
        state.data,
      )) {
        update(updatedData);
      }
    });
  }

  @override
  Future<List<Post>> onLoadAsync() async {
    final posts = await _postsRepository.getPosts();

    return _filterPosts(posts);
  }

  List<Post> _filterPosts(List<Post> posts) {
    return posts.where((post) => post.id < 5).toList();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }

  @override
  Future<void> close() async {
    await _postsSubscription.cancel();
    return super.close();
  }
}
