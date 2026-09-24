import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/theme/index.dart';

abstract final class AppTextStyles() {
  static TextStyle get appTitle => const TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: .w700,
  );

  static TextStyle get error => const TextStyle(
    color: Colors.red,
    fontSize: 10,
    height: 0.5,
  );
}
