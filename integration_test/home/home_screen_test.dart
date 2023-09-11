import 'package:flutter/material.dart';
import 'package:flutter_guidelines/app.dart';
import 'package:flutter_guidelines/app_initialization.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/screens/home/dashboard/dashboard_screen.dart';
import 'package:flutter_guidelines/screens/login/widgets/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  // Configure the app.
  await initializeDotenv();
  await initializeLogger();
  await initializeLocalization();
  initializeCrashlytics();
  initializeBlocObserver();
  configureAuthDependencies();

  patrolWidgetTest('Home screen dashboard tab is opened initially', ($) async {
    // Load auth screen.
    await $.pumpWidget(
      EasyLocalization(
        path: CodegenLoader.path,
        supportedLocales: CodegenLoader.supportedLocales,
        fallbackLocale: CodegenLoader.supportedLocales.last,
        assetLoader: const CodegenLoader(),
        child: SoftonixApp(),
      ),
    );

    // Wait couple of seconds till splash is removed.
    await $.pumpAndSettle();

    // We land on Home screen, dashboard tab.
    expect($(DashboardScreen), findsOneWidget);
  });

  patrolWidgetTest('Change localization', ($) async {
    // Get the current locale.
    final currentLocale = CodegenLoader.supportedLocales.last;

    // Load auth screen.
    await $.pumpWidget(
      EasyLocalization(
        path: CodegenLoader.path,
        supportedLocales: CodegenLoader.supportedLocales,
        fallbackLocale: currentLocale,
        assetLoader: const CodegenLoader(),
        child: SoftonixApp(),
      ),
    );

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

  patrolWidgetTest('Logout', ($) async {
    // Load auth screen.
    await $.pumpWidget(
      EasyLocalization(
        path: CodegenLoader.path,
        supportedLocales: CodegenLoader.supportedLocales,
        fallbackLocale: CodegenLoader.supportedLocales.last,
        assetLoader: const CodegenLoader(),
        child: SoftonixApp(),
      ),
    );

    // Wait couple of seconds till splash is removed.
    await $.pumpAndSettle();

    // Open drawer.
    final drawer = $(Scaffold).$(Icon);
    await drawer.tap();
    await $.pump();

    // Trigger logout.
    final logout = $(ListTile).last;
    await logout.tap();
    await $.pump();

    // We land on Home screen, dashboard tab.
    expect($(LoginForm), findsOneWidget);
  });
}
