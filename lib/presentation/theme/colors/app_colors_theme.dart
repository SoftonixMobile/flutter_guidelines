import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppColorsTheme extends ThemeExtension<AppColorsTheme> {
  final Color primary;
  final Color success;
  final Color danger;
  final Color grey;
  final Color background;
  final Color surface;
  final Color onPrimary;
  final Color textPrimary;
  final Color textSecondary;

  const AppColorsTheme({
    required this.primary,
    required this.success,
    required this.danger,
    required this.grey,
    required this.background,
    required this.surface,
    required this.onPrimary,
    required this.textPrimary,
    required this.textSecondary,
  });

  factory AppColorsTheme.light() => const AppColorsTheme(
    primary: AppColors.primary,
    success: AppColors.success,
    danger: AppColors.danger,
    grey: AppColors.grey,
    background: AppColors.backgroundLight,
    surface: AppColors.surfaceLight,
    onPrimary: AppColors.surfaceLight,
    textPrimary: AppColors.textPrimaryLight,
    textSecondary: AppColors.textSecondaryLight,
  );

  factory AppColorsTheme.dark() => const AppColorsTheme(
    primary: AppColors.primaryDark,
    success: AppColors.success,
    danger: AppColors.danger,
    grey: AppColors.greyLight,
    background: AppColors.backgroundDark,
    surface: AppColors.surfaceDark,
    onPrimary: AppColors.surfaceLight,
    textPrimary: AppColors.textPrimaryDark,
    textSecondary: AppColors.textSecondaryDark,
  );

  @override
  AppColorsTheme copyWith({
    Color? primary,
    Color? success,
    Color? danger,
    Color? grey,
    Color? background,
    Color? surface,
    Color? onPrimary,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return AppColorsTheme(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      danger: danger ?? this.danger,
      grey: grey ?? this.grey,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      onPrimary: onPrimary ?? this.onPrimary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    ThemeExtension<AppColorsTheme>? other,
    double t,
  ) {
    if (other is! AppColorsTheme) return this;
    return AppColorsTheme(
      primary: Color.lerp(primary, other.primary, t)!,
      success: Color.lerp(success, other.success, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}
