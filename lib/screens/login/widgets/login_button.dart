import 'package:flutter/material.dart';

import 'package:bouncing_widget/bouncing_widget.dart';

import 'package:flutter_guidelines/styles/index.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      duration: const Duration(milliseconds: 100),
      scaleFactor: 1,
      onPressed: onPressed,
      child: Container(
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
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
