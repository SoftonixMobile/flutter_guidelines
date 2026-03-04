import 'package:flutter/material.dart';

import 'package:flutter_guidelines/presentation/theme/index.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.child,
    this.width,
    this.height,
    super.key,
  });

  final double? width;
  final double? height;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorsTheme;

    return Card(
      elevation: 6,
      color: colors.primary,
      shadowColor: colors.textPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        height: height,
        width: width ?? 0,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 14,
        ),
        child: child,
      ),
    );
  }
}
