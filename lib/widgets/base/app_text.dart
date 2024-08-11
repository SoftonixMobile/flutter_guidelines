import 'package:flutter/widgets.dart';

import 'package:flutter_guidelines/core/index.dart';

enum TypographyStyle {
  head1,
  head2,
  subhead1,
  subhead2,
  body1,
  body2,
  caption1,
  caption2,
}

class AppText extends Text {
  const AppText(
    super.data, {
    super.key,
    super.style,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  })  : typographyStyle = null,
        assert(
          style == null || (color == null && decoration == null),
          'Cannot provide both a color or decoration and a style\n'
          'To provide both, use '
          '"style: TextStyle(color:color, decoration:decoration)".',
        );

  final Color? color;
  final TextDecoration? decoration;

  final TypographyStyle? typographyStyle;

  // Head 1-2
  const AppText.head1(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.head1;

  const AppText.head2(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.head2;

  // Subhead 1-2
  const AppText.subhead1(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.subhead1;

  const AppText.subhead2(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.subhead2;

  // Body 1-2
  const AppText.body1(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.body1;

  const AppText.body2(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.body2;

  // Caption 1-2
  const AppText.caption1(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.caption1;

  const AppText.caption2(
    super.data, {
    super.key,
    super.overflow,
    super.maxLines,
    this.color,
    this.decoration,
  }) : typographyStyle = TypographyStyle.caption2;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final typography = context.theme.text;

    final themeTextStyle = switch (typographyStyle) {
      TypographyStyle.head1 => typography.head1,
      TypographyStyle.head2 => typography.head2,
      TypographyStyle.subhead1 => typography.subhead1,
      TypographyStyle.subhead2 => typography.subhead2,
      TypographyStyle.body1 => typography.body1,
      TypographyStyle.body2 => typography.body2,
      TypographyStyle.caption1 => typography.caption1,
      TypographyStyle.caption2 => typography.caption2,
      // Add some default TextStyle for AppText()
      _ => null,
    };

    final effectiveStyle = style ??
        themeTextStyle?.copyWith(
          color: color ?? colors.foreground,
          decoration: decoration,
          overflow: overflow,
        );

    return Text(
      data ?? '',
      key: key,
      style: effectiveStyle,
      overflow: overflow,
    );
  }
}
