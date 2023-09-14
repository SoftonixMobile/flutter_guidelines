import 'package:flutter/material.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/screens/home/dashboard/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../helpers/test_helper.dart';

Future<void> main() async {
  // Configure the app.
  await TestHelper.initApp();

  patrolTest('Home screen dashboard tab is opened initially', ($) async {
    // Load auth screen.
    await TestHelper.pumpSoftonixApp($);

    // We land on Home screen, dashboard tab.
    expect($(DashboardScreen), findsOneWidget);
  });

  patrolTest('Change localization', ($) async {
    // Get the current locale.
    final currentLocale = CodegenLoader.supportedLocales.last;

    // Load auth screen.
    await TestHelper.pumpSoftonixApp($);

    // Wait couple of seconds till splash is removed.
    await $.pumpAndSettle();

    // Open drawer.
    final drawer = $(Scaffold).$(Icon);
    await drawer.tap();
    await $.pump();

    // Trigger change of localization.
    final words = CodegenLoader.mapLocales[
        '${currentLocale.languageCode}_${currentLocale.countryCode}'];
    final language = $(words?['languageName']);

    await $(language).tap();
    await $.pump();

    // If we don't have English button, language is changed.
    expect(language, findsNothing);
  });
}
