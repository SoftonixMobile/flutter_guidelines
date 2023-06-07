import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/',
      page: AuthRoute.page,
      children: [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(
          page: HomeRouter.page,
          children: [
            AutoRoute(
              path: '',
              page: HomeRoute.page,
              children: [
                AutoRoute(page: DashboardRoute.page),
                AutoRoute(
                  page: MessagesRoute.page,
                  children: [
                    AutoRoute(page: ChatsRoute.page),
                    AutoRoute(page: PostsRoute.page),
                  ],
                ),
                AutoRoute(page: SettingsRoute.page),
              ],
            ),
            AutoRoute(page: ChatDetailsRoute.page),
          ],
        ),
      ],
    ),
  ];
}
