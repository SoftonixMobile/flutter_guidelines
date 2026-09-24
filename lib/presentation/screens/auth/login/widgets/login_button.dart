import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/theme/index.dart';

class const LoginButton({
  super.key,
  required final VoidCallback onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colors = theme.colorsTheme;
    final typography = theme.typographyTheme;

    return BouncingWidget(
      duration: const Duration(milliseconds: 100),
      onPressed: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: colors.primary,
          borderRadius: const .all(
            Radius.circular(6),
          ),
        ),
        child: Center(
          child: Text(
            'Login',
            style: typography.titleSmall.copyWith(
              color: colors.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
