import 'package:flutter_guidelines/screens/home/dashboard/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../helpers/test_helper.dart';

void main() {
  patrolTest(
    'Logout first, then login',
    nativeAutomation: true,
    ($) async {
      // Configure the app.
      await TestHelper.initApp();

      // Load auth screen.
      await TestHelper.pumpAppAndSettle($);

      // We land on Home screen, dashboard tab.
      expect($(DashboardScreen), findsOneWidget);

      // Close app.
      await $.native.pressHome();

      // Open app.
      await $.native.openApp();

      // We land on Home screen, dashboard tab.
      expect($(DashboardScreen), findsOneWidget);
    },
  );
}
