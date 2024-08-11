import 'package:flutter/material.dart';

import 'package:flutter_guidelines/styles/index.dart';
import 'package:flutter_guidelines/widgets/base/app_text.dart';

/// Text styles of the app.
/// Should contain info only about unmodifiable props of typography.
/// The props such as colors and decoration will be added via [AppText].
class AppTextStyles {
  static const _family = FontFamily.poppins;

  // Head 1-2
  static const TextStyle head1 = TextStyle(
    fontFamily: _family,
    fontSize: 48,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle head2 = TextStyle(
    fontFamily: _family,
    fontSize: 36,
    fontWeight: FontWeight.w900,
  );

  // Subhead 1-2
  static const TextStyle subhead1 = TextStyle(
    fontFamily: _family,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subhead2 = TextStyle(
    fontFamily: _family,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  // Body 1-2
  static const TextStyle body1 = TextStyle(
    fontFamily: _family,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: _family,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  // Caption 1-2
  static const TextStyle caption1 = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: _family,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
