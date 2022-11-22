import 'package:auto_route/auto_route.dart';

import 'settings_screen.dart';

const settingsRouter = AutoRoute(
  name: 'SettingsRouter',
  page: SettingsScreen,
);

const settingModals = <AutoRoute<dynamic>>[];
