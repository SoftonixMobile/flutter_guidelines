import 'package:flutter/material.dart';

import 'package:flutter_guidelines/app/index.dart';
import 'package:flutter_guidelines/localization/index.dart';

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
