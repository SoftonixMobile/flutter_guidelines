import 'dart:math';

import 'package:flutter/material.dart';

class SliverAppBarDelegate({
  required final double minHeight,
  required final double maxHeight,
  required final Widget child,
}) extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
