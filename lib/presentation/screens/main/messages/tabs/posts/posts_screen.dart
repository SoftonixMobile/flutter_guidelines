import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'posts_bloc.dart';

@RoutePage()
class PostsScreen extends StatelessWidget implements AutoRouteWrapper {
  const PostsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostsBloc>()..lazyLoad(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final postsBloc = context.read<PostsBloc>();

    return RefreshIndicator(
      onRefresh: postsBloc.loadAsyncFuture,
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

                        return GestureDetector(
                          behavior: .opaque,
                          onTap: () => context.pushRoute(
                            PostModalRoute(
                              post: post,
                              onSuccess: (post, {required isEditing}) {
                                if (isEditing) {
                                  postsBloc.editItem(post);
                                } else {
                                  postsBloc.addItem(post);
                                }
                              },
                            ),
                          ),
                          child: Padding(
                            padding: const .all(8),
                            child: Text('Post ${post.name}'),
                          ),
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
