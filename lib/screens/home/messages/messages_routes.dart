import 'package:auto_route/auto_route.dart';

import 'messages_screen.dart';

const profileRouter = AutoRoute(
  page: MessagesScreen,
  children: [
    AutoRoute(
      page: ChatsScreen,
      initial: true,
    ),
    AutoRoute(
      page: PostsScreen,
    ),
  ],
);
