import 'dart:async';

import 'package:flutter/material.dart';

import 'package:data_provider/data_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';
import 'post_modal_bloc.dart';

@RoutePage()
class PostModalScreen extends StatelessWidget implements AutoRouteWrapper {
  const PostModalScreen({
    super.key,
    this.post,
    this.onSuccess,
  });

  final Post? post;

  final void Function(Post, {required bool isEditing})? onSuccess;

  @override
  Widget wrappedRoute(BuildContext context) {
    final formBloc = getIt<PostModalBloc>(param1: post);

    return BlocProvider(
      create: (context) => formBloc,
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<PostModalBloc>();

    return CustomFormBlocListener<PostModalBloc, Post>(
      formBloc: formBloc,
      onSuccess: (_, state) {
        onSuccess?.call(state.response!, isEditing: formBloc.isEditing);

        unawaited(context.maybePop());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Modal'),
        ),
        body: Center(
          child: Column(
            children: [
              TextInputFormBuilder(
                fieldBloc: formBloc.name,
              ),
              ElevatedButton(
                onPressed: formBloc.submit,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
