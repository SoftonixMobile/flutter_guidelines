import 'package:flutter/material.dart';

import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';

export 'chats/chats_screen.dart';
export 'posts/posts_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    final tabs = [
      LocaleKeys.chats.tr(),
      LocaleKeys.posts.tr(),
      'Notes',
    ];

    const routes = <PageRouteInfo<dynamic>>[
      ChatsRoute(),
      PostsRoute(),
    ];

    return CustomTabsRouter(
      appBarTitle: LocaleKeys.messages.tr(),
      tabs: tabs,
      routes: routes,
    );
  }
}
