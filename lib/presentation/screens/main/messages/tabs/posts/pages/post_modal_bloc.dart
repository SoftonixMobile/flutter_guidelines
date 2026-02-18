import 'dart:async';

import 'package:data_provider/models.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/data/repositories/index.dart';

@injectable
class PostModalBloc extends FormBloc<Post, String> {
  late final TextFieldBloc name;

  final Post? initial;
  final PostsRepository postsRepository;

  PostModalBloc(
    @factoryParam this.initial,
    this.postsRepository,
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
    final payload = (initial ?? const .new()).copyWith(name: name.value ?? '');

    final response = isCreating
        ? await postsRepository.createPost(payload)
        : await postsRepository.updatePost(payload);

    emitSuccess(response);
  }
}
