import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  /// Theme.of(context)
  ThemeData get theme => Theme.of(this);
}
