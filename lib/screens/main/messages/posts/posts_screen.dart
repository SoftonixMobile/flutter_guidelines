import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'posts_bloc.dart';

@RoutePage()
class PostsScreen extends StatelessWidget implements AutoRouteWrapper {
  const PostsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<PostsBloc>().load();

    return this;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<PostsBloc>().loadAsyncFuture,
      child: CustomScrollView(
        slivers: [
          BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              switch (state.status) {
                case NetworkStatus.initial:
                case NetworkStatus.loading:
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                case NetworkStatus.success:
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = state.data[index];

                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('Post ${post.id}'),
                        );
                      },
                      childCount: state.data.length,
                    ),
                  );
                case NetworkStatus.failure:
                  return const SliverFillRemaining(
                    child: Center(child: Text('Something went wrong')),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
