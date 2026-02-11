// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:{{project_name}}/models/index.dart' as _i13;
import 'package:{{project_name}}/screens/auth/login/login_screen.dart' as _i4;
import 'package:{{project_name}}/screens/main/dashboard/dashboard_screen.dart'
    as _i3;
import 'package:{{project_name}}/screens/main/main_screen.dart' as _i5;
import 'package:{{project_name}}/screens/main/main_wrapper_screen.dart'
    as _i6;
import 'package:{{project_name}}/screens/main/messages/chats/chats_screen.dart'
    as _i2;
import 'package:{{project_name}}/screens/main/messages/chats/pages/chat_details/chat_details_screen.dart'
    as _i1;
import 'package:{{project_name}}/screens/main/messages/messages_screen.dart'
    as _i7;
import 'package:{{project_name}}/screens/main/messages/posts/posts_screen.dart'
    as _i8;
import 'package:{{project_name}}/screens/main/settings/settings_screen.dart'
    as _i10;
import 'package:{{project_name}}/screens/root_screen.dart' as _i9;

/// generated route for
/// [_i1.ChatDetailsScreen]
class ChatDetailsRoute extends _i11.PageRouteInfo<ChatDetailsRouteArgs> {
  ChatDetailsRoute({
    _i12.Key? key,
    required _i13.Chat chat,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ChatDetailsRoute.name,
         args: ChatDetailsRouteArgs(key: key, chat: chat),
         initialChildren: children,
       );

  static const String name = 'ChatDetailsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatDetailsRouteArgs>();
      return _i1.ChatDetailsScreen(key: args.key, chat: args.chat);
    },
  );
}

class ChatDetailsRouteArgs {
  const ChatDetailsRouteArgs({this.key, required this.chat});

  final _i12.Key? key;

  final _i13.Chat chat;

  @override
  String toString() {
    return 'ChatDetailsRouteArgs{key: $key, chat: $chat}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChatDetailsRouteArgs) return false;
    return key == other.key && chat == other.chat;
  }

  @override
  int get hashCode => key.hashCode ^ chat.hashCode;
}

/// generated route for
/// [_i2.ChatsScreen]
class ChatsRoute extends _i11.PageRouteInfo<void> {
  const ChatsRoute({List<_i11.PageRouteInfo>? children})
    : super(ChatsRoute.name, initialChildren: children);

  static const String name = 'ChatsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i2.ChatsScreen());
    },
  );
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute({List<_i11.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i4.LoginScreen());
    },
  );
}

/// generated route for
/// [_i5.MainScreen]
class MainRoute extends _i11.PageRouteInfo<void> {
  const MainRoute({List<_i11.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainScreen();
    },
  );
}

/// generated route for
/// [_i6.MainWrapperScreen]
class MainRouter extends _i11.PageRouteInfo<void> {
  const MainRouter({List<_i11.PageRouteInfo>? children})
    : super(MainRouter.name, initialChildren: children);

  static const String name = 'MainRouter';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.MainWrapperScreen();
    },
  );
}

/// generated route for
/// [_i7.MessagesScreen]
class MessagesRoute extends _i11.PageRouteInfo<void> {
  const MessagesRoute({List<_i11.PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.MessagesScreen();
    },
  );
}

/// generated route for
/// [_i8.PostsScreen]
class PostsRoute extends _i11.PageRouteInfo<void> {
  const PostsRoute({List<_i11.PageRouteInfo>? children})
    : super(PostsRoute.name, initialChildren: children);

  static const String name = 'PostsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i8.PostsScreen());
    },
  );
}

/// generated route for
/// [_i9.RootScreen]
class RootRoute extends _i11.PageRouteInfo<void> {
  const RootRoute({List<_i11.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.RootScreen();
    },
  );
}

/// generated route for
/// [_i10.SettingsScreen]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute({List<_i11.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.SettingsScreen();
    },
  );
}
