import 'package:flutter/material.dart';

class const CustomCard({
  required final Widget child,
  final double? width,
  final double? height,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.lightBlue,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: .all(.circular(12)),
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
