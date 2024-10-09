import 'package:flutter/material.dart';

import 'package:flutter_guidelines/styles/colors.dart';

@immutable
class AppColorsData extends ThemeExtension<AppColorsData> {
  const AppColorsData({
    required this.primary,
    required this.grey,
    required this.black,
    required this.white,
    required this.background,
    required this.foreground,
    required this.success,
    required this.warning,
    required this.error,
  });

  final Color primary;
  final Color grey;
  final Color black;
  final Color white;
  final Color background;
  final Color foreground;
  final Color success;
  final Color warning;
  final Color error;

  /// Default color palette
  factory AppColorsData.base() {
    return const AppColorsData(
      primary: AppColors.primary,
      grey: AppColors.grey,
      black: AppColors.black,
      white: AppColors.white,
      foreground: AppColors.black,
      background: AppColors.white,
      success: AppColors.success,
      warning: AppColors.warning,
      error: AppColors.error,
    );
  }

  /// Dark theme color palette
  factory AppColorsData.dark() {
    return const AppColorsData(
      primary: AppColors.primary,
      grey: AppColors.grey,
      black: AppColors.black,
      white: AppColors.white,
      foreground: AppColors.white,
      background: AppColors.black,
      success: AppColors.success,
      warning: AppColors.warning,
      error: AppColors.error,
    );
  }

  @override
  ThemeExtension<AppColorsData> copyWith({
    Color? primary,
    Color? grey,
    Color? black,
    Color? white,
    Color? background,
    Color? foreground,
    Color? success,
    Color? warning,
    Color? error,
  }) {
    return AppColorsData(
      primary: primary ?? this.primary,
      grey: grey ?? this.grey,
      black: black ?? this.black,
      white: white ?? this.black,
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
    );
  }

  @override
  ThemeExtension<AppColorsData> lerp(
    covariant ThemeExtension<AppColorsData>? other,
    double t,
  ) {
    if (other is! AppColorsData) {
      return this;
    }

    return AppColorsData(
      primary: Color.lerp(primary, other.primary, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      black: Color.lerp(black, other.black, t)!,
      white: Color.lerp(white, other.white, t)!,
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
    );
  }
}
