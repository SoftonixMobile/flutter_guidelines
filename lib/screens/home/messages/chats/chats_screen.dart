import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'bloc/chats_bloc.dart';

@RoutePage()
class ChatsScreen extends StatelessWidget implements AutoRouteWrapper {
  const ChatsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<ChatsBloc>().add(const ChatsEvent.load());

    return this;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        final bloc = context.read<ChatsBloc>()..add(const ChatsEvent.load());

        return bloc.stream
            .firstWhere((state) => state.status != NetworkStatus.loading);
      },
      child: CustomScrollView(
        slivers: [
          BlocBuilder<ChatsBloc, ChatsState>(
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
                      (BuildContext context, int index) {
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

                case NetworkStatus.failure:
                  return SliverFillRemaining(
                    child: Center(child: Text(state.errorMessage ?? '')),
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
