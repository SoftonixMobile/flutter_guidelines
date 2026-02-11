import 'package:flutter/material.dart';

import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/widgets/index.dart';

@RoutePage()
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      context.tr(LocaleKeys.chats),
      context.tr(LocaleKeys.posts),
    ];

    const routes = [
      ChatsRoute(),
      PostsRoute(),
    ];

    return CustomTabsRouter(
      appBarTitle: context.tr(LocaleKeys.messages),
      tabs: tabs,
      routes: routes,
    );
  }
}
