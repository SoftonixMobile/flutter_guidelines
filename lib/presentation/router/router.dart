import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: RootRoute.page,
      children: [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: MainRouter.page,
          children: [
            AutoRoute(
              path: '',
              page: MainRoute.page,
              children: [
                AutoRoute(page: DashboardRoute.page),
                AutoRoute(
                  page: MessagesTabsRoute.page,
                  children: [
                    AutoRoute(page: ChatsRoute.page),
                    AutoRoute(page: PostsRoute.page),
                  ],
                ),
                AutoRoute(page: SettingsRoute.page),
              ],
            ),
            AutoRoute(page: PostModalRoute.page),
            AutoRoute(page: ChatDetailsRoute.page),
          ],
        ),
      ],
    ),
  ];
}
