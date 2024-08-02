import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors_data/colors_data.dart';
import 'text_theme_data/text_theme_data.dart';

part 'theme_data.freezed.dart';

// Add more Data if needed. This can be some ContainerThemeData or NavigationBarTheme.
// There you can have background color, and foreground color.
@freezed
class AppThemeData with _$AppThemeData {
  const factory AppThemeData({
    // COLORS
    required AppColorsData colors,
    // TYPOGRAPHY & ICONOGRAPHY
    required AppTextThemeData textTheme,
    // COMPONENT THEMES
  }) = _AppThemeData;

  factory AppThemeData.regular() => AppThemeData(
        colors: AppColorsData.base(),
        textTheme: AppTextThemeData.base(),
      );
}
