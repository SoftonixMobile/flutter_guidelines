import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'bloc/chats_bloc.dart';

@RoutePage()
class ChatsScreen extends StatelessWidget implements AutoRouteWrapper {
  const ChatsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatsBloc>()..add(const ChatsEvent.load()),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        final chatsBloc = context.read<ChatsBloc>()
          ..add(const ChatsEvent.load());

        return chatsBloc.stream.firstWhere(
          (state) => state.status != .loading,
        );
      },
      child: CustomScrollView(
        slivers: [
          BlocBuilder<ChatsBloc, ChatsState>(
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
                        final chat = state.chats[index];

                        return InkWell(
                          onTap: () => context.router.push(
                            ChatDetailsRoute(chat: chat),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(chat.name),
                          ),
                        );
                      },
                      childCount: state.chats.length,
                    ),
                  );
                case .failure:
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(state.errorMessage ?? 'Something went wrong'),
                    ),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
