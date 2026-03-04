import 'package:flutter/material.dart';

import 'package:bouncing_widget/bouncing_widget.dart';

import 'package:flutter_guidelines/presentation/theme/index.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

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
          borderRadius: const BorderRadius.all(
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
