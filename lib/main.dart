import 'package:flutter/material.dart';

import 'package:flutter_guidelines/core/localization/index.dart';
import 'core/initialization/app_initialization.dart';
import 'presentation/app.dart';

void main() async {
  await initializeApp();

  runApp(
    EasyLocalization(
      path: CodegenLoader.path,
      supportedLocales: CodegenLoader.supportedLocales,
      fallbackLocale: CodegenLoader.supportedLocales.last,
      assetLoader: const CodegenLoader(),
      child: FlutterGuidelines(),
    ),
  );
}
