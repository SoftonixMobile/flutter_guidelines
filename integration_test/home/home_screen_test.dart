import 'package:flutter/material.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/screens/home/dashboard/dashboard_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../helpers/test_helper.dart';

void main() {
  group('Home screen test', () {
    setUp(TestHelper.initApp);

    patrolTest(
      'Home screen dashboard tab is opened initially',
      ($) async {
        // Load auth screen.
        await TestHelper.pumpAppAndSettle($);

        // We land on Home screen, dashboard tab.
        expect($(DashboardScreen), findsOneWidget);
      },
    );

    patrolTest(
      'Change localization',
      ($) async {
        // Get the current locale.
        final currentLocale = CodegenLoader.supportedLocales.last;

        // Load auth screen.
        await TestHelper.pumpAppAndSettle($);

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

        // Return language back
        await drawer.tap();
        await $.pump();
        await $('French').tap();
        await $.pump();

        expect(language, findsOneWidget);
      },
    );
  });
}
