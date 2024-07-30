import 'package:flutter/rendering.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_guidelines/styles/text_styles.dart';

part 'typography_data.freezed.dart';

@freezed
class AppTypographyData with _$AppTypographyData {
  const factory AppTypographyData({
    required TextStyle head1,
    required TextStyle head2,
    required TextStyle subhead1,
    required TextStyle subhead2,
    required TextStyle body1,
    required TextStyle body2,
    required TextStyle caption1,
    required TextStyle caption2,
  }) = _AppTypographyData;

  // Default typography
  factory AppTypographyData.base() {
    return const AppTypographyData(
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
}
