import 'package:auto_route/auto_route.dart';

import 'package:flutter_guidelines/screens/index.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      page: AuthScreen,
      children: [
        AutoRoute(
          page: LoginScreen,
        ),
        AutoRoute(
          name: 'HomeRouter',
          page: HomeWrapperScreen,
          children: [
            AutoRoute(
              initial: true,
              page: HomeScreen,
              children: [
                dashboardRouter,
                messagesRouter,
                settingsRouter,
              ],
            ),
            ...dashboardModals,
            ...messagesModals,
            ...settingModals,
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
