import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/theme/index.dart';

abstract final class AppTheme() {
  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: .fromSeed(
        seedColor: AppColors.primary,
      ),
      fontFamily: FontFamily.poppins,
    );
  }
}
