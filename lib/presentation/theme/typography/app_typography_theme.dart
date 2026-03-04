import 'package:flutter/material.dart';

import 'index.dart';

class AppTypographyTheme extends ThemeExtension<AppTypographyTheme> {
  final TextStyle displayLarge;
  final TextStyle displaySmall;
  final TextStyle titleLarge;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodySmall;
  final TextStyle captionLarge;
  final TextStyle captionSmall;

  const AppTypographyTheme({
    required this.displayLarge,
    required this.displaySmall,
    required this.titleLarge,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodySmall,
    required this.captionLarge,
    required this.captionSmall,
  });

  factory AppTypographyTheme.fromFontFamily({
    required String fontFamily,
  }) {
    return AppTypographyTheme(
      displayLarge: AppTypography.displayLarge(fontFamily: fontFamily),
      displaySmall: AppTypography.displaySmall(fontFamily: fontFamily),
      titleLarge: AppTypography.titleLarge(fontFamily: fontFamily),
      titleSmall: AppTypography.titleSmall(fontFamily: fontFamily),
      bodyLarge: AppTypography.bodyLarge(fontFamily: fontFamily),
      bodySmall: AppTypography.bodySmall(fontFamily: fontFamily),
      captionLarge: AppTypography.captionLarge(fontFamily: fontFamily),
      captionSmall: AppTypography.captionSmall(fontFamily: fontFamily),
    );
  }

  @override
  AppTypographyTheme copyWith({
    TextStyle? displayLarge,
    TextStyle? displaySmall,
    TextStyle? titleLarge,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodySmall,
    TextStyle? captionLarge,
    TextStyle? captionSmall,
  }) {
    return AppTypographyTheme(
      displayLarge: displayLarge ?? this.displayLarge,
      displaySmall: displaySmall ?? this.displaySmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodySmall: bodySmall ?? this.bodySmall,
      captionLarge: captionLarge ?? this.captionLarge,
      captionSmall: captionSmall ?? this.captionSmall,
    );
  }

  @override
  ThemeExtension<AppTypographyTheme> lerp(
    ThemeExtension<AppTypographyTheme>? other,
    double t,
  ) {
    if (other is! AppTypographyTheme) return this;
    return AppTypographyTheme(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      captionLarge: TextStyle.lerp(captionLarge, other.captionLarge, t)!,
      captionSmall: TextStyle.lerp(captionSmall, other.captionSmall, t)!,
    );
  }
}
