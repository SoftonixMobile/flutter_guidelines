// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_guidelines/screens/home/dashboard/dashboard_screen.dart'
    as _i2;
import 'package:flutter_guidelines/screens/home/messages/messages_screen.dart'
    as _i3;
import 'package:flutter_guidelines/screens/home/settings/settings_screen.dart'
    as _i4;
import 'package:flutter_guidelines/screens/index.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AuthScreen());
    },
    LoginRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.LoginScreen());
    },
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    DashboardRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.DashboardScreen());
    },
    MessagesRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.MessagesScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.SettingsScreen());
    },
    ChatsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.ChatsScreen());
    },
    PostsRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.PostsScreen());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(AuthRoute.name, path: '/', children: [
          _i5.RouteConfig(LoginRoute.name,
              path: 'login-screen', parent: AuthRoute.name),
          _i5.RouteConfig(HomeRoute.name,
              path: 'home-screen',
              parent: AuthRoute.name,
              children: [
                _i5.RouteConfig(DashboardRoute.name,
                    path: '', parent: HomeRoute.name),
                _i5.RouteConfig(MessagesRoute.name,
                    path: 'messages-screen',
                    parent: HomeRoute.name,
                    children: [
                      _i5.RouteConfig(ChatsRoute.name,
                          path: '', parent: MessagesRoute.name),
                      _i5.RouteConfig(PostsRoute.name,
                          path: 'posts-screen', parent: MessagesRoute.name)
                    ]),
                _i5.RouteConfig(SettingsRoute.name,
                    path: 'settings-screen', parent: HomeRoute.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i5.PageRouteInfo<void> {
  const AuthRoute({List<_i5.PageRouteInfo>? children})
      : super(AuthRoute.name, path: '/', initialChildren: children);

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-screen');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-screen', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.DashboardScreen]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: '');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i3.MessagesScreen]
class MessagesRoute extends _i5.PageRouteInfo<void> {
  const MessagesRoute({List<_i5.PageRouteInfo>? children})
      : super(MessagesRoute.name,
            path: 'messages-screen', initialChildren: children);

  static const String name = 'MessagesRoute';
}

/// generated route for
/// [_i4.SettingsScreen]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings-screen');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i3.ChatsScreen]
class ChatsRoute extends _i5.PageRouteInfo<void> {
  const ChatsRoute() : super(ChatsRoute.name, path: '');

  static const String name = 'ChatsRoute';
}

/// generated route for
/// [_i3.PostsScreen]
class PostsRoute extends _i5.PageRouteInfo<void> {
  const PostsRoute() : super(PostsRoute.name, path: 'posts-screen');

  static const String name = 'PostsRoute';
}
