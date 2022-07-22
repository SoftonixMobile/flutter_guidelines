import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/models/index.dart';
import 'posts_bloc.dart';

export 'pages/index.dart';

class PostsScreen extends StatelessWidget implements AutoRouteWrapper {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<PostsBloc>().load();

    return this;
  }

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return BlocBuilder<PostsBloc, NetworkListState<Post>>(
      builder: (context, state) {
        switch (state.status) {
          case NetworkStatus.initial:
          case NetworkStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case NetworkStatus.success:
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                final chat = state.data[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(chat.name),
                );
              },
            );
          case NetworkStatus.failure:
            return Center(child: Text(state.errorMessage ?? ''));
        }
      },
    );
  }
}
