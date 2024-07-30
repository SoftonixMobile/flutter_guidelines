import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_guidelines/styles/colors.dart';

part 'colors_data.freezed.dart';

@freezed
class AppColorsData with _$AppColorsData {
  const factory AppColorsData({
    required Color primary,
    required Color add,
    required Color grey,
    required Color black,
    required Color white,
  }) = _AppColorsData;

  // Default color palette
  factory AppColorsData.base() {
    return const AppColorsData(
      primary: AppColors.primary,
      add: AppColors.add,
      grey: AppColors.grey,
      black: AppColors.black,
      white: AppColors.white,
    );
  }
}
