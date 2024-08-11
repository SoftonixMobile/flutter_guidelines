import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_guidelines/styles/index.dart';
import 'package:flutter_guidelines/theme/index.dart';
import '../app/app.dart';

class AppTheme {
  static ThemeData getAppTheme(BuildContext context) {
    final useDarkTheme = context.read<SwitchProvider>().isDarkTheme;

    return ThemeData(
      extensions: useDarkTheme
          ? [
              AppColorsData.dark(),
              AppTextData.base(),
            ]
          : [
              AppColorsData.base(),
              AppTextData.base().apply(fontFamily: 'Courier'),
            ],
      useMaterial3: false,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ),
    );
  }
}
