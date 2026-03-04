import 'package:flutter/material.dart';

import 'index.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension ThemeDataX on ThemeData {
  bool get isLight => brightness == Brightness.light;
  bool get isDark => brightness == Brightness.dark;

  AppColorsTheme get colorsTheme => extension<AppColorsTheme>()!;
  AppTypographyTheme get typographyTheme => extension<AppTypographyTheme>()!;
}

extension TextStyleX on TextStyle {
  TextStyle get poppins => copyWith(fontFamily: FontFamily.poppins);

  TextStyle get w300 => copyWith(fontWeight: FontWeight.w300);
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);

  TextStyle get f64 => copyWith(fontSize: 64);
  TextStyle get f56 => copyWith(fontSize: 56);
  TextStyle get f48 => copyWith(fontSize: 48);
  TextStyle get f32 => copyWith(fontSize: 32);
  TextStyle get f30 => copyWith(fontSize: 30);
  TextStyle get f24 => copyWith(fontSize: 24);
  TextStyle get f20 => copyWith(fontSize: 20);
  TextStyle get f18 => copyWith(fontSize: 18);
  TextStyle get f16 => copyWith(fontSize: 16);
  TextStyle get f14 => copyWith(fontSize: 14);
  TextStyle get f12 => copyWith(fontSize: 12);
  TextStyle get f10 => copyWith(fontSize: 10);

  TextStyle get l64 => copyWith(height: 64 / fontSize!);
  TextStyle get l56 => copyWith(height: 56 / fontSize!);
  TextStyle get l42 => copyWith(height: 42 / fontSize!);
  TextStyle get l38 => copyWith(height: 38 / fontSize!);
  TextStyle get l34 => copyWith(height: 34 / fontSize!);
  TextStyle get l30 => copyWith(height: 30 / fontSize!);
  TextStyle get l26 => copyWith(height: 26 / fontSize!);
  TextStyle get l24 => copyWith(height: 24 / fontSize!);
  TextStyle get l22 => copyWith(height: 22 / fontSize!);
  TextStyle get l20 => copyWith(height: 20 / fontSize!);
}
