import 'package:material_ui/material_ui.dart';

import 'index.dart';

class const AppTypographyTheme({
  required final TextStyle displayLarge,
  required final TextStyle displaySmall,
  required final TextStyle titleLarge,
  required final TextStyle titleSmall,
  required final TextStyle bodyLarge,
  required final TextStyle bodySmall,
  required final TextStyle captionLarge,
  required final TextStyle captionSmall,
}) extends ThemeExtension<AppTypographyTheme> {
  factory fromFontFamily({
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
      displayLarge: .lerp(displayLarge, other.displayLarge, t)!,
      displaySmall: .lerp(displaySmall, other.displaySmall, t)!,
      titleLarge: .lerp(titleLarge, other.titleLarge, t)!,
      titleSmall: .lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: .lerp(bodyLarge, other.bodyLarge, t)!,
      bodySmall: .lerp(bodySmall, other.bodySmall, t)!,
      captionLarge: .lerp(captionLarge, other.captionLarge, t)!,
      captionSmall: .lerp(captionSmall, other.captionSmall, t)!,
    );
  }
}
