import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_guidelines/styles/text_styles.dart';

part 'text_theme_data.freezed.dart';

/// Stores TextStyles of the app.
@freezed
class AppTextThemeData with _$AppTextThemeData {
  const AppTextThemeData._();

  const factory AppTextThemeData({
    required TextStyle head1,
    required TextStyle head2,
    required TextStyle subhead1,
    required TextStyle subhead2,
    required TextStyle body1,
    required TextStyle body2,
    required TextStyle caption1,
    required TextStyle caption2,
  }) = _AppTextThemeData;

  // Default typography
  factory AppTextThemeData.base() {
    return const AppTextThemeData(
      head1: AppTextStyles.head1,
      head2: AppTextStyles.head2,
      subhead1: AppTextStyles.subhead1,
      subhead2: AppTextStyles.subhead2,
      body1: AppTextStyles.body1,
      body2: AppTextStyles.body2,
      caption1: AppTextStyles.caption1,
      caption2: AppTextStyles.caption2,
    );
  }

  /// Creates a copy of this text theme but with the given field replaced in
  /// each of the individual text styles.
  AppTextThemeData apply({
    String? fontFamily,
    Color? displayColor,
    // Add more props later if needed
  }) {
    return AppTextThemeData(
      head1: head1.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      head2: head2.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      subhead1: subhead1.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      subhead2: subhead2.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      body1: body1.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      body2: body2.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      caption1: caption1.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
      caption2: caption2.apply(
        color: displayColor,
        fontFamily: fontFamily,
      ),
    );
  }

  /// Linearly interpolate between two text themes.
  static AppTextThemeData lerp(
      AppTextThemeData? a, AppTextThemeData? b, double t) {
    if (identical(a, b) && a != null) {
      return a;
    }

    return AppTextThemeData(
      head1: TextStyle.lerp(a?.head1, b?.head1, t)!,
      head2: TextStyle.lerp(a?.head2, b?.head2, t)!,
      subhead1: TextStyle.lerp(a?.subhead1, b?.subhead1, t)!,
      subhead2: TextStyle.lerp(a?.subhead2, b?.subhead2, t)!,
      body1: TextStyle.lerp(a?.body1, b?.body1, t)!,
      body2: TextStyle.lerp(a?.body2, b?.body2, t)!,
      caption1: TextStyle.lerp(a?.caption1, b?.caption1, t)!,
      caption2: TextStyle.lerp(a?.caption2, b?.caption2, t)!,
    );
  }
}
