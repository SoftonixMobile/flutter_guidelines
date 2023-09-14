import 'package:flutter_guidelines/screens/home/dashboard/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../helpers/test_helper.dart';

Future<void> main() async {
  // Configure the app.
  await TestHelper.initApp();

  patrolTest('Home screen dashboard tab is opened initially',
      nativeAutomation: true, ($) async {
    // Load auth screen.
    await TestHelper.pumpSoftonixApp($);

    // We land on Home screen, dashboard tab.
    expect($(DashboardScreen), findsOneWidget);

    // Close app.
    await $.native.pressHome();
    await $.pumpAndSettle();

    // Open app.
    await $.native.openApp();
    await $.pumpAndSettle();

    // We land on Home screen, dashboard tab.
    expect($(DashboardScreen), findsOneWidget);
  });
}
