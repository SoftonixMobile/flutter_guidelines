import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';

@RoutePage()
class const MessagesScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const tabs = [
      'Chats',
      'Posts',
    ];

    const routes = [
      ChatsRoute(),
      PostsRoute(),
    ];

    return const CustomTabsRouter(
      appBarTitle: 'Messages',
      tabs: tabs,
      routes: routes,
    );
  }
}
