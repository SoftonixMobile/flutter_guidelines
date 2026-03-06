import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';

@injectable
class PostFormBloc extends FormBloc<Post, String> {
  late final TextFieldBloc name;

  final Post? initial;
  final PostsRepository _postsRepository;

  PostFormBloc(
    @factoryParam this.initial,
    this._postsRepository,
  ) : super(customSubmit: false, isEditing: initial != null) {
    name = TextFieldBloc(
      initialValue: initial?.name ?? '',
      required: true,
    );

    addFields([
      name,
    ]);
  }

  @override
  FutureOr<void> onSubmit() async {
    final payload = (initial ?? const Post()).copyWith(name: name.value ?? '');

    final response = isCreating
        ? await _postsRepository.createPost(payload)
        : await _postsRepository.updatePost(payload);

    emitSuccess(response);
  }
}
