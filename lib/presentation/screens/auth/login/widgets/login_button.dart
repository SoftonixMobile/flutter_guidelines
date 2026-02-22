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
    return BouncingWidget(
      duration: const Duration(milliseconds: 100),
      onPressed: onPressed,
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
