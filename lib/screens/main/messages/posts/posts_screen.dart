import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'posts_bloc.dart';

@RoutePage()
class const PostsScreen({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
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
                case .initial:
                case .loading:
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                case .success:
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final post = state.data[index];

                        return Padding(
                          padding: const .all(8),
                          child: Text('Post ${post.id}'),
                        );
                      },
                      childCount: state.data.length,
                    ),
                  );
                case .failure:
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
