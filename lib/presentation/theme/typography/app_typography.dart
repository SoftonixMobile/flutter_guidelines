import 'package:material_ui/material_ui.dart';

abstract final class AppTypography() {
  static TextStyle displayLarge({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: .w700,
    letterSpacing: 0,
    height: 1.25,
  );

  static TextStyle displaySmall({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: .w600,
    letterSpacing: 0,
    height: 1.33,
  );

  static TextStyle titleLarge({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: .w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static TextStyle titleSmall({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: .w600,
    letterSpacing: 0,
    height: 1.5,
  );

  static TextStyle bodyLarge({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: .w400,
    letterSpacing: 0,
    height: 1.5,
  );

  static TextStyle bodySmall({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: .w400,
    letterSpacing: 0,
    height: 1.43,
  );

  static TextStyle captionLarge({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: .w500,
    letterSpacing: 0,
    height: 1.33,
  );

  static TextStyle captionSmall({String? fontFamily}) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: .w400,
    letterSpacing: 0,
    height: 1.4,
  );
}
