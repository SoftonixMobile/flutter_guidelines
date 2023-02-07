// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i9;
import 'package:flutter/material.dart' as _i8;
import 'package:{{project_name}}/models/index.dart' as _i10;
import 'package:{{project_name}}/screens/home/dashboard/dashboard_screen.dart'
    as _i3;
import 'package:{{project_name}}/screens/home/messages/chats/index.dart' as _i2;
import 'package:{{project_name}}/screens/home/messages/messages_screen.dart'
    as _i4;
import 'package:{{project_name}}/screens/home/messages/posts/index.dart' as _i6;
import 'package:{{project_name}}/screens/home/settings/settings_screen.dart'
    as _i5;
import 'package:{{project_name}}/screens/routes.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.AuthScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i1.LoginScreen()),
      );
    },
    HomeRouter.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeWrapperScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    ChatDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ChatDetailsRouteArgs>();
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i2.ChatDetailsScreen(
          key: args.key,
          chat: args.chat,
        ),
      );
    },
    DashboardRouter.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardScreen(),
      );
    },
    MessagesRouter.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i4.MessagesScreen(),
      );
    },
    SettingsRouter.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: const _i5.SettingsScreen(),
      );
    },
    ChatsRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i2.ChatsScreen()),
      );
    },
    PostsRoute.name: (routeData) {
      return _i7.AdaptivePage<dynamic>(
        routeData: routeData,
        child: _i7.WrappedRoute(child: const _i6.PostsScreen()),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          AuthRoute.name,
          path: '/',
          children: [
            _i7.RouteConfig(
              LoginRoute.name,
              path: 'login-screen',
              parent: AuthRoute.name,
            ),
            _i7.RouteConfig(
              HomeRouter.name,
              path: 'home-wrapper-screen',
              parent: AuthRoute.name,
              children: [
                _i7.RouteConfig(
                  HomeRoute.name,
                  path: '',
                  parent: HomeRouter.name,
                  children: [
                    _i7.RouteConfig(
                      DashboardRouter.name,
                      path: '',
                      parent: HomeRoute.name,
                    ),
                    _i7.RouteConfig(
                      MessagesRouter.name,
                      path: 'messages-screen',
                      parent: HomeRoute.name,
                      children: [
                        _i7.RouteConfig(
                          ChatsRoute.name,
                          path: 'chats-screen',
                          parent: MessagesRouter.name,
                        ),
                        _i7.RouteConfig(
                          PostsRoute.name,
                          path: 'posts-screen',
                          parent: MessagesRouter.name,
                        ),
                      ],
                    ),
                    _i7.RouteConfig(
                      SettingsRouter.name,
                      path: 'settings-screen',
                      parent: HomeRoute.name,
                    ),
                  ],
                ),
                _i7.RouteConfig(
                  ChatDetailsRoute.name,
                  path: 'chat-details-screen',
                  parent: HomeRouter.name,
                ),
              ],
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i7.PageRouteInfo<void> {
  const AuthRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-screen',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.HomeWrapperScreen]
class HomeRouter extends _i7.PageRouteInfo<void> {
  const HomeRouter({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRouter.name,
          path: 'home-wrapper-screen',
          initialChildren: children,
        );

  static const String name = 'HomeRouter';
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          path: '',
          initialChildren: children,
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.ChatDetailsScreen]
class ChatDetailsRoute extends _i7.PageRouteInfo<ChatDetailsRouteArgs> {
  ChatDetailsRoute({
    _i9.Key? key,
    required _i10.Chat chat,
  }) : super(
          ChatDetailsRoute.name,
          path: 'chat-details-screen',
          args: ChatDetailsRouteArgs(
            key: key,
            chat: chat,
          ),
        );

  static const String name = 'ChatDetailsRoute';
}

class ChatDetailsRouteArgs {
  const ChatDetailsRouteArgs({
    this.key,
    required this.chat,
  });

  final _i9.Key? key;

  final _i10.Chat chat;

  @override
  String toString() {
    return 'ChatDetailsRouteArgs{key: $key, chat: $chat}';
  }
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRouter extends _i7.PageRouteInfo<void> {
  const DashboardRouter()
      : super(
          DashboardRouter.name,
          path: '',
        );

  static const String name = 'DashboardRouter';
}

/// generated route for
/// [_i4.MessagesScreen]
class MessagesRouter extends _i7.PageRouteInfo<void> {
  const MessagesRouter({List<_i7.PageRouteInfo>? children})
      : super(
          MessagesRouter.name,
          path: 'messages-screen',
          initialChildren: children,
        );

  static const String name = 'MessagesRouter';
}

/// generated route for
/// [_i5.SettingsScreen]
class SettingsRouter extends _i7.PageRouteInfo<void> {
  const SettingsRouter()
      : super(
          SettingsRouter.name,
          path: 'settings-screen',
        );

  static const String name = 'SettingsRouter';
}

/// generated route for
/// [_i2.ChatsScreen]
class ChatsRoute extends _i7.PageRouteInfo<void> {
  const ChatsRoute()
      : super(
          ChatsRoute.name,
          path: 'chats-screen',
        );

  static const String name = 'ChatsRoute';
}

/// generated route for
/// [_i6.PostsScreen]
class PostsRoute extends _i7.PageRouteInfo<void> {
  const PostsRoute()
      : super(
          PostsRoute.name,
          path: 'posts-screen',
        );

  static const String name = 'PostsRoute';
}
