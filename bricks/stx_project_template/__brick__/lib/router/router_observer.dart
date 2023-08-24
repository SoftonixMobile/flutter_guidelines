import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:{{project_name}}/services/logger/index.dart';

class RouterObserver extends AutoRouterObserver {
  RouterObserver(this.logger);

  final Logger logger;

  @override
  void didPush(Route route, Route? previousRoute) {
    logger.log(
      'New route pushed: ${route.settings.name}',
      category: 'navigation',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    logger.log('Route popped: ${route.settings.name}', category: 'navigation');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    logger.log('Tab route visited: ${route.name}', category: 'navigation');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    logger.log('Tab route re-visited: ${route.name}', category: 'navigation');
  }
}
