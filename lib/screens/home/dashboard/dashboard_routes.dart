import 'package:auto_route/auto_route.dart';

import 'dashboard_screen.dart';

const dashboardRouter = AutoRoute(
  initial: true,
  name: 'DashboardRouter',
  page: DashboardScreen,
);

const dashboardModals = <AutoRoute<dynamic>>[];
