import 'package:flutter/material.dart';

import 'package:flutter_guidelines/core/initialization/app_initialization.dart';
import 'package:flutter_guidelines/presentation/app.dart';
import 'package:flutter_guidelines/presentation/localization/index.dart';

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
