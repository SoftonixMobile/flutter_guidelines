// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:data_provider/data_provider.dart' as _i15;
import 'package:flutter/material.dart' as _i13;
import 'package:flutter_guidelines/domain/models/index.dart' as _i14;
import 'package:flutter_guidelines/presentation/screens/auth/login/login_screen.dart'
    as _i4;
import 'package:flutter_guidelines/presentation/screens/main/dashboard/dashboard_screen.dart'
    as _i3;
import 'package:flutter_guidelines/presentation/screens/main/main_screen.dart'
    as _i5;
import 'package:flutter_guidelines/presentation/screens/main/main_wrapper_screen.dart'
    as _i6;
import 'package:flutter_guidelines/presentation/screens/main/messages/messages_tags_screen.dart'
    as _i7;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/chats/chats_screen.dart'
    as _i2;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/chats/pages/chat_details/chat_details_screen.dart'
    as _i1;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/posts/pages/post_modal_screen.dart'
    as _i8;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/posts/posts_screen.dart'
    as _i9;
import 'package:flutter_guidelines/presentation/screens/main/settings/settings_screen.dart'
    as _i11;
import 'package:flutter_guidelines/presentation/screens/root_screen.dart'
    as _i10;

/// generated route for
/// [_i1.ChatDetailsScreen]
class ChatDetailsRoute extends _i12.PageRouteInfo<ChatDetailsRouteArgs> {
  ChatDetailsRoute({
    _i13.Key? key,
    required _i14.Chat chat,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ChatDetailsRoute.name,
         args: ChatDetailsRouteArgs(key: key, chat: chat),
         initialChildren: children,
       );

  static const String name = 'ChatDetailsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatDetailsRouteArgs>();
      return _i1.ChatDetailsScreen(key: args.key, chat: args.chat);
    },
  );
}

class ChatDetailsRouteArgs {
  const ChatDetailsRouteArgs({this.key, required this.chat});

  final _i13.Key? key;

  final _i14.Chat chat;

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
class ChatsRoute extends _i12.PageRouteInfo<void> {
  const ChatsRoute({List<_i12.PageRouteInfo>? children})
    : super(ChatsRoute.name, initialChildren: children);

  static const String name = 'ChatsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i2.ChatsScreen());
    },
  );
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute({List<_i12.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<void> {
  const LoginRoute({List<_i12.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i4.LoginScreen());
    },
  );
}

/// generated route for
/// [_i5.MainScreen]
class MainRoute extends _i12.PageRouteInfo<void> {
  const MainRoute({List<_i12.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainScreen();
    },
  );
}

/// generated route for
/// [_i6.MainWrapperScreen]
class MainRouter extends _i12.PageRouteInfo<void> {
  const MainRouter({List<_i12.PageRouteInfo>? children})
    : super(MainRouter.name, initialChildren: children);

  static const String name = 'MainRouter';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.MainWrapperScreen();
    },
  );
}

/// generated route for
/// [_i7.MessagesTabsScreen]
class MessagesTabsRoute extends _i12.PageRouteInfo<void> {
  const MessagesTabsRoute({List<_i12.PageRouteInfo>? children})
    : super(MessagesTabsRoute.name, initialChildren: children);

  static const String name = 'MessagesTabsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.MessagesTabsScreen();
    },
  );
}

/// generated route for
/// [_i8.PostModalScreen]
class PostModalRoute extends _i12.PageRouteInfo<PostModalRouteArgs> {
  PostModalRoute({
    _i13.Key? key,
    _i15.Post? post,
    void Function(_i15.Post, {required bool isEditing})? onSuccess,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         PostModalRoute.name,
         args: PostModalRouteArgs(key: key, post: post, onSuccess: onSuccess),
         initialChildren: children,
       );

  static const String name = 'PostModalRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PostModalRouteArgs>(
        orElse: () => const PostModalRouteArgs(),
      );
      return _i12.WrappedRoute(
        child: _i8.PostModalScreen(
          key: args.key,
          post: args.post,
          onSuccess: args.onSuccess,
        ),
      );
    },
  );
}

class PostModalRouteArgs {
  const PostModalRouteArgs({this.key, this.post, this.onSuccess});

  final _i13.Key? key;

  final _i15.Post? post;

  final void Function(_i15.Post, {required bool isEditing})? onSuccess;

  @override
  String toString() {
    return 'PostModalRouteArgs{key: $key, post: $post, onSuccess: $onSuccess}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PostModalRouteArgs) return false;
    return key == other.key && post == other.post;
  }

  @override
  int get hashCode => key.hashCode ^ post.hashCode;
}

/// generated route for
/// [_i9.PostsScreen]
class PostsRoute extends _i12.PageRouteInfo<void> {
  const PostsRoute({List<_i12.PageRouteInfo>? children})
    : super(PostsRoute.name, initialChildren: children);

  static const String name = 'PostsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i9.PostsScreen());
    },
  );
}

/// generated route for
/// [_i10.RootScreen]
class RootRoute extends _i12.PageRouteInfo<void> {
  const RootRoute({List<_i12.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.RootScreen();
    },
  );
}

/// generated route for
/// [_i11.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingsScreen();
    },
  );
}
