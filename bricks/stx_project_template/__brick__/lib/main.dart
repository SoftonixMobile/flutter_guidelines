import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/core/initialization/app_initialization.dart';
import 'package:{{project_name}}/presentation/app.dart';
import 'package:{{project_name}}/presentation/localization/index.dart';

void main() async {
  await initializeApp();

  runApp(
    TranslationProvider(
      child: {{#pascalCase}}{{project_name}}{{/pascalCase}}App(),
    ),
  );
}
