import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.slotWidget,
    this.width,
    this.height,
    super.key,
  });

  final double? width;
  final double? height;

  final Widget slotWidget;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: Colors.lightBlue,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        height: height,
        width: width ?? 0,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 14,
        ),
        child: slotWidget,
      ),
    );
  }
}
