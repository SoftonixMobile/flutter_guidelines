import 'package:auto_route/auto_route.dart';

import 'package:flutter_guidelines/screens/index.dart';
import 'package:flutter_guidelines/screens/posts/posts_routes.dart';
import 'package:flutter_guidelines/screens/profile/profile_routes.dart';
import 'package:flutter_guidelines/screens/settings/settings_routes.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: AuthScreen,
      initial: true,
      children: [
        AutoRoute(
          path: 'login',
          page: LoginScreen,
        ),
        AutoRoute(
          path: '',
          page: HomeScreen,
          children: [
            profileRouter,
            postsRouter,
            settingsRouter,
          ],
        ),
      ],
    ),
    RedirectRoute(path: '*', redirectTo: ''),
  ],
)
class $AppRouter {}
