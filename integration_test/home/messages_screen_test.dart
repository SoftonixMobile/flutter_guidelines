import 'package:flutter_guidelines/app.dart';
import 'package:flutter_guidelines/app_initialization.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Messages screen test', () {
    patrolWidgetTest(
        'Open messages screen, check how we are navigated to the chats',
        ($) async {
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
      await $.pump();

      // We land on Home screen, dashboard tab.
      expect($('Dashboard Screen'), findsOneWidget);
    });
  });
}
