import 'package:flutter/material.dart';

import 'package:flutter_guidelines/theme/data/index.dart';

extension ThemeDataX on ThemeData {
  /// Theme.of(context).extension<AppColorsData>()!
  AppColorsData get colors => extension<AppColorsData>()!;

  /// Theme.of(context).extension<AppTextData>()!
  AppTextData get text => extension<AppTextData>()!;
}
