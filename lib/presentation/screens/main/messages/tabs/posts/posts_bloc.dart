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
  Future<List<Post>> onLoadAsync() {
    return _postsRepository.getPosts();
  }

  @override
  bool equals(Post item1, Post item2) {
    return item1.id == item2.id;
  }
}
