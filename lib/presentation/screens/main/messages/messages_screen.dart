import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';

@RoutePage()
class const MessagesScreen({super.key}) extends StatelessWidget {
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
