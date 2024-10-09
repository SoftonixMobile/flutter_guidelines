import 'package:flutter/material.dart';

import 'package:flutter_guidelines/styles/text_styles.dart';

/// Stores TextStyles of the app.
@immutable
class AppTextData extends ThemeExtension<AppTextData> {
  const AppTextData({
    required this.head1,
    required this.head2,
    required this.subhead1,
    required this.subhead2,
    required this.body1,
    required this.body2,
    required this.caption1,
    required this.caption2,
  });

  final TextStyle head1;
  final TextStyle head2;
  final TextStyle subhead1;
  final TextStyle subhead2;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption1;
  final TextStyle caption2;

  // Default typography
  factory AppTextData.base() {
    return const AppTextData(
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

  @override
  AppTextData copyWith({
    TextStyle? head1,
    TextStyle? head2,
    TextStyle? subhead1,
    TextStyle? subhead2,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? caption1,
    TextStyle? caption2,
  }) {
    return AppTextData(
      head1: head1 ?? this.head1,
      head2: head2 ?? this.head2,
      subhead1: subhead1 ?? this.subhead1,
      subhead2: subhead2 ?? this.subhead2,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      caption1: caption1 ?? this.caption1,
      caption2: caption2 ?? this.caption2,
    );
  }

  /// Creates a copy of this text theme but with the given field replaced in
  /// each of the individual text styles.
  AppTextData apply({
    String? fontFamily,
    Color? displayColor,
    // Add more props later if needed
  }) {
    return AppTextData(
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
  @override
  ThemeExtension<AppTextData> lerp(
    AppTextData? other,
    double t,
  ) {
    if (other is! AppTextData) {
      return this;
    }

    return AppTextData(
      head1: TextStyle.lerp(head1, other.head1, t)!,
      head2: TextStyle.lerp(head2, other.head2, t)!,
      subhead1: TextStyle.lerp(subhead1, other.subhead1, t)!,
      subhead2: TextStyle.lerp(subhead2, other.subhead2, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      caption1: TextStyle.lerp(caption1, other.caption1, t)!,
      caption2: TextStyle.lerp(caption2, other.caption2, t)!,
    );
  }
}
