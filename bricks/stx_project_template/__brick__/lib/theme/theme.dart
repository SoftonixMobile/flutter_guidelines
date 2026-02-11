import 'package:flutter/material.dart';

import 'package:{{project_name}}/theme/index.dart';

abstract final class AppTheme {
  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
      fontFamily: FontFamily.poppins,
    );
  }
}
