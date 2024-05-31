import 'package:flutter_guidelines/app.dart';
import 'package:flutter_guidelines/app_initialization.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:patrol/patrol.dart';

class TestHelper {
  static Future<void> initApp() async {
    try {
      await initializeDotenv();
      await initializeLogger();
      await initializeLocalization();
      initializeCrashlytics();
      initializeBlocObserver();
      configureAuthDependencies();
    } catch (_) {}
  }

  static Future<void> pumpAppAndSettle(PatrolIntegrationTester tester) async {
    await tester.pumpWidgetAndSettle(
      EasyLocalization(
        path: CodegenLoader.path,
        supportedLocales: CodegenLoader.supportedLocales,
        fallbackLocale: CodegenLoader.supportedLocales.last,
        assetLoader: const CodegenLoader(),
        child: FlutterGuidelines(),
      ),
    );

    // Wait couple of seconds till splash is removed.
    await tester.pumpAndSettle();
  }
}
