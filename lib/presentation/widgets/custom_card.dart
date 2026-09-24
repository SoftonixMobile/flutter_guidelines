import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/theme/index.dart';

class const CustomCard({
  required final Widget child,
  final double? width,
  final double? height,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorsTheme;

    return Card(
      elevation: 6,
      color: colors.primary,
      shadowColor: colors.textPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const .all(
            Radius.circular(12),
          ),
        ),
        height: height,
        width: width ?? 0,
        padding: const .symmetric(
          vertical: 20,
          horizontal: 14,
        ),
        child: child,
      ),
    );
  }
}
