import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/theme/index.dart';

class const LoginButton({
  super.key,
  required final VoidCallback onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        minimumSize: const .fromHeight(40),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 15, fontWeight: .w500),
        shape: const RoundedRectangleBorder(
          borderRadius: .all(.circular(6)),
        ),
      ),
      child: const Text('Login'),
    );
  }
}
