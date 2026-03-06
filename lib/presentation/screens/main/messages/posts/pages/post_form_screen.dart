import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';
import 'post_form_bloc.dart';

@RoutePage()
class PostFormScreen extends StatelessWidget implements AutoRouteWrapper {
  const PostFormScreen({
    super.key,
    this.post,
    this.onSuccess,
  });

  final Post? post;

  final void Function(Post, bool)? onSuccess;

  @override
  Widget wrappedRoute(BuildContext context) {
    final formBloc = getIt<PostFormBloc>(param1: post);

    return BlocProvider(
      create: (context) => formBloc,
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<PostFormBloc>();

    return CustomFormBlocListener<PostFormBloc, Post>(
      formBloc: formBloc,
      onSuccess: (_, state) {
        onSuccess?.call(state.response!, formBloc.isEditing);

        unawaited(context.maybePop());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post Modal'),
        ),
        body: Center(
          child: Column(
            children: [
              TextInputFieldBuilder(
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
