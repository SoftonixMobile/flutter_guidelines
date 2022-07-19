import 'package:auto_route/auto_route.dart';

import 'package:{{project_name}}/screens/index.dart';
import 'package:{{project_name}}/screens/posts/posts_routes.dart';
import 'package:{{project_name}}/screens/profile/profile_routes.dart';
import 'package:{{project_name}}/screens/settings/settings_routes.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: AuthScreen,
      initial: true,
      children: [
        AutoRoute(
          page: LoginScreen,
        ),
        AutoRoute(
          page: HomeScreen,
          children: [
            profileRouter,
            postsRouter,
            settingsRouter,
          ],
        ),
      ],
    ),
  ],
)
class $AppRouter {}
