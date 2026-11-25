import 'package:material_ui/material_ui.dart';

import 'index.dart';

abstract final class AppTheme() {
  static ThemeData lightTheme() {
    const fontFamily = FontFamily.poppins;

    final colors = AppColorsTheme.light();
    final typography = AppTypographyTheme.fromFontFamily(
      fontFamily: fontFamily,
    );

    return ThemeData(
      brightness: .light,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colors.background,
      colorScheme: .light(
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
          borderRadius: .circular(12),
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
      brightness: .dark,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: colors.background,
      colorScheme: .dark(
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
          borderRadius: .circular(12),
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
