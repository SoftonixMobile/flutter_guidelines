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
import 'package:{{project_name}}/screens/auth_screen.dart' as _i1;
import 'package:{{project_name}}/screens/home/dashboard/dashboard_screen.dart'
    as _i4;
import 'package:{{project_name}}/screens/home/home_screen.dart' as _i5;
import 'package:{{project_name}}/screens/home/home_wrapper.dart' as _i6;
import 'package:{{project_name}}/screens/home/messages/chats/chats_screen.dart'
    as _i3;
import 'package:{{project_name}}/screens/home/messages/chats/pages/chat_details/chat_details_screen.dart'
    as _i2;
import 'package:{{project_name}}/screens/home/messages/messages_screen.dart'
    as _i8;
import 'package:{{project_name}}/screens/home/messages/posts/posts_screen.dart'
    as _i9;
import 'package:{{project_name}}/screens/home/settings/settings_screen.dart'
    as _i10;
import 'package:{{project_name}}/screens/login/login_screen.dart' as _i7;

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i11.PageRouteInfo<void> {
  const AuthRoute({List<_i11.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthScreen();
    },
  );
}

/// generated route for
/// [_i2.ChatDetailsScreen]
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
      return _i2.ChatDetailsScreen(key: args.key, chat: args.chat);
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
}

/// generated route for
/// [_i3.ChatsScreen]
class ChatsRoute extends _i11.PageRouteInfo<void> {
  const ChatsRoute({List<_i11.PageRouteInfo>? children})
    : super(ChatsRoute.name, initialChildren: children);

  static const String name = 'ChatsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i3.ChatsScreen());
    },
  );
}

/// generated route for
/// [_i4.DashboardScreen]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute({List<_i11.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeWrapperScreen]
class HomeRouter extends _i11.PageRouteInfo<void> {
  const HomeRouter({List<_i11.PageRouteInfo>? children})
    : super(HomeRouter.name, initialChildren: children);

  static const String name = 'HomeRouter';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeWrapperScreen();
    },
  );
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i7.LoginScreen());
    },
  );
}

/// generated route for
/// [_i8.MessagesScreen]
class MessagesRoute extends _i11.PageRouteInfo<void> {
  const MessagesRoute({List<_i11.PageRouteInfo>? children})
    : super(MessagesRoute.name, initialChildren: children);

  static const String name = 'MessagesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.MessagesScreen();
    },
  );
}

/// generated route for
/// [_i9.PostsScreen]
class PostsRoute extends _i11.PageRouteInfo<void> {
  const PostsRoute({List<_i11.PageRouteInfo>? children})
    : super(PostsRoute.name, initialChildren: children);

  static const String name = 'PostsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i9.PostsScreen());
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
