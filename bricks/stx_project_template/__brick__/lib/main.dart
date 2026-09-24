import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/app/index.dart';
import 'package:{{project_name}}/localization/index.dart';

void main() async {
  await initializeApp();

  runApp(
    EasyLocalization(
      path: CodegenLoader.path,
      supportedLocales: CodegenLoader.supportedLocales,
      fallbackLocale: CodegenLoader.supportedLocales.last,
      assetLoader: const CodegenLoader(),
      child: {{#pascalCase}}{{project_name}}{{/pascalCase}}App(),
    ),
  );
}
