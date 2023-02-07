import 'package:auto_route/auto_route.dart';

import 'messages_screen.dart';
import 'chats/index.dart';
import 'posts/index.dart';

const messagesRouter = AutoRoute(
  name: 'MessagesRouter',
  page: MessagesScreen,
  children: [
    AutoRoute(
      page: ChatsScreen,
    ),
    AutoRoute(
      page: PostsScreen,
    ),
  ],
);

const messagesModals = [
  AutoRoute(
    page: ChatDetailsScreen,
  ),
];
