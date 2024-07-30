import 'package:freezed_annotation/freezed_annotation.dart';

import 'colors_data/colors_data.dart';
import 'typography_data/typography_data.dart';

part 'theme_data.freezed.dart';

@freezed
class AppThemeData with _$AppThemeData {
  const factory AppThemeData({
    required AppColorsData colors,
    required AppTypographyData typography,
  }) = _AppThemeData;

  factory AppThemeData.regular() => AppThemeData(
        colors: AppColorsData.base(),
        typography: AppTypographyData.base(),
      );
}
