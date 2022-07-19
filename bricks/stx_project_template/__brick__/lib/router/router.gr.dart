// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:{{project_name}}/screens/index.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AuthRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AuthScreen());
    },
    LoginRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i2.WrappedRoute(child: const _i1.LoginScreen()));
    },
    HomeRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomeScreen());
    },
    ProfileRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.ProfileScreen());
    },
    PostsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.PostsScreen());
    },
    SettingsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.SettingsScreen());
    },
    InfoRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.InfoScreen());
    },
    DocumentsRoute.name: (routeData) {
      return _i2.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.DocumentsScreen());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(AuthRoute.name, path: '/', children: [
          _i2.RouteConfig(LoginRoute.name,
              path: 'login-screen', parent: AuthRoute.name),
          _i2.RouteConfig(HomeRoute.name,
              path: 'home-screen',
              parent: AuthRoute.name,
              children: [
                _i2.RouteConfig(ProfileRoute.name,
                    path: '',
                    parent: HomeRoute.name,
                    children: [
                      _i2.RouteConfig(InfoRoute.name,
                          path: '', parent: ProfileRoute.name),
                      _i2.RouteConfig(DocumentsRoute.name,
                          path: 'documents-screen', parent: ProfileRoute.name)
                    ]),
                _i2.RouteConfig(PostsRoute.name,
                    path: 'posts-screen', parent: HomeRoute.name),
                _i2.RouteConfig(SettingsRoute.name,
                    path: 'settings-screen', parent: HomeRoute.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.AuthScreen]
class AuthRoute extends _i2.PageRouteInfo<void> {
  const AuthRoute({List<_i2.PageRouteInfo>? children})
      : super(AuthRoute.name, path: '/', initialChildren: children);

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-screen');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.HomeScreen]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeRoute.name, path: 'home-screen', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ProfileScreen]
class ProfileRoute extends _i2.PageRouteInfo<void> {
  const ProfileRoute({List<_i2.PageRouteInfo>? children})
      : super(ProfileRoute.name, path: '', initialChildren: children);

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i1.PostsScreen]
class PostsRoute extends _i2.PageRouteInfo<void> {
  const PostsRoute() : super(PostsRoute.name, path: 'posts-screen');

  static const String name = 'PostsRoute';
}

/// generated route for
/// [_i1.SettingsScreen]
class SettingsRoute extends _i2.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings-screen');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i1.InfoScreen]
class InfoRoute extends _i2.PageRouteInfo<void> {
  const InfoRoute() : super(InfoRoute.name, path: '');

  static const String name = 'InfoRoute';
}

/// generated route for
/// [_i1.DocumentsScreen]
class DocumentsRoute extends _i2.PageRouteInfo<void> {
  const DocumentsRoute() : super(DocumentsRoute.name, path: 'documents-screen');

  static const String name = 'DocumentsRoute';
}
