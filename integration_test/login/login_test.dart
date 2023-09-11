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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  patrolWidgetTest('Logout first, then login', ($) async {
    // Configure the app.
    await initializeDotenv();
    await initializeLogger();
    await initializeLocalization();
    initializeCrashlytics();
    initializeBlocObserver();
    configureAuthDependencies();

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

    // Check if we are logged out by any chance.
    final loginForm = $(LoginForm);

    if (!loginForm.exists) {
      // Open drawer.
      final drawer = $(Scaffold).$(Icon);
      await drawer.tap();
      await $.pump();

      // Trigger logout.
      final logout = $('Sign Out');
      await logout.tap();
      await $.pump();
    }

    // Trigger error.
    final textFields = $(TextField);
    await textFields.first.enterText('tester@gmail.com');
    await textFields.last.enterText('12');
    final loginButton = $(LoginButton);
    await loginButton.tap();
    await $.pump();

    expect(
      $('Password length must be at least 6 characters'),
      findsOneWidget,
    );

    // Enter valid password and sign in again.
    await textFields.last.enterText('123456');
    await loginButton.tap();
    await $.pump();

    // Validate that dashboard is opened.
    expect($(DashboardScreen), findsOneWidget);
  });
}
