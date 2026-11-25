import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

class const AppColorsTheme({
  required final Color primary,
  required final Color success,
  required final Color danger,
  required final Color grey,
  required final Color background,
  required final Color surface,
  required final Color onPrimary,
  required final Color textPrimary,
  required final Color textSecondary,
}) extends ThemeExtension<AppColorsTheme> {
  factory light() => const AppColorsTheme(
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

  factory dark() => const AppColorsTheme(
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
      primary: .lerp(primary, other.primary, t)!,
      success: .lerp(success, other.success, t)!,
      danger: .lerp(danger, other.danger, t)!,
      grey: .lerp(grey, other.grey, t)!,
      background: .lerp(background, other.background, t)!,
      surface: .lerp(surface, other.surface, t)!,
      onPrimary: .lerp(onPrimary, other.onPrimary, t)!,
      textPrimary: .lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: .lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}
