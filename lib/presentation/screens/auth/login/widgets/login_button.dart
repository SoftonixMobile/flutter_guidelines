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

    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const .fromHeight(40),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        textStyle: typography.titleSmall,
        shape: const RoundedRectangleBorder(
          borderRadius: .all(.circular(6)),
        ),
      ),
      child: const Text('Login'),
    );
  }
}
