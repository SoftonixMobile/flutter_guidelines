import 'package:flutter/material.dart';

import 'index.dart';

abstract final class AppTheme {
  static ThemeData lightTheme() {
    const fontFamily = FontFamily.poppins;

    final colors = AppColorsTheme.light();
    final typography = AppTypographyTheme.fromFontFamily(
      fontFamily: fontFamily,
    );

    return ThemeData(
      brightness: Brightness.light,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        surface: colors.surface,
        onPrimary: colors.onPrimary,
        onSurface: colors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerColor: colors.grey.withValues(alpha: 0.3),
      extensions: [
        colors,
        typography,
      ],
    );
  }

  static ThemeData darkTheme() {
    const fontFamily = FontFamily.poppins;

    final colors = AppColorsTheme.dark();
    final typography = AppTypographyTheme.fromFontFamily(
      fontFamily: fontFamily,
    );

    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colors.background,
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        surface: colors.surface,
        onPrimary: colors.onPrimary,
        onSurface: colors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dividerColor: colors.grey.withValues(alpha: 0.3),
      extensions: [
        colors,
        typography,
      ],
    );
  }
}
