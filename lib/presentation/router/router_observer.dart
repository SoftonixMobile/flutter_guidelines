import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/logger/logger.dart';

class RouterObserver(final Logger _logger) extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    _logger.log(
      'New route pushed: ${route.settings.name}',
      category: 'navigation',
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.log('Route popped: ${route.settings.name}', category: 'navigation');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _logger.log('Tab route visited: ${route.name}', category: 'navigation');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _logger.log('Tab route re-visited: ${route.name}', category: 'navigation');
  }
}
