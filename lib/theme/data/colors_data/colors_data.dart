import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_guidelines/styles/colors.dart';

part 'colors_data.freezed.dart';

@freezed
class AppColorsData with _$AppColorsData {
  const factory AppColorsData({
    required Color primary,
    required Color grey,
    required Color black,
    required Color white,
    required Color background,
    required Color foreground,
    required Color success,
    required Color warning,
    required Color error,
  }) = _AppColorsData;

  // Default color palette
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
}
