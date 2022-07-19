import 'package:auto_route/auto_route.dart';

import 'package:{{project_name}}/screens/profile/index.dart';

const profileRouter = AutoRoute(
  initial: true,
  page: ProfileScreen,
  children: [
    AutoRoute(
      page: InfoScreen,
      initial: true,
    ),
    AutoRoute(
      page: DocumentsScreen,
    )
  ],
);
