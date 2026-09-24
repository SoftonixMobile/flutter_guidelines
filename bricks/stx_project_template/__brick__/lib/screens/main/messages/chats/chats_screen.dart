import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/router/index.dart';

import 'bloc/chats_bloc.dart';

@RoutePage()
class const ChatsScreen({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<ChatsBloc>().add(const .load());

    return this;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        final chatsBloc = context.read<ChatsBloc>()..add(const .load());

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
                            padding: const .all(8),
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
