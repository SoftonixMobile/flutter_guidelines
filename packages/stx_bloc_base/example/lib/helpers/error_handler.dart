import 'dart:io';

import 'package:stx_bloc_base/stx_bloc_base.dart';

class ErrorHandler {
  static String parse(Object e) {
    if (e is HttpException) {
      return e.message;
    }

    if (e is NetworkDeleteException) {
      return 'NetworkDeleteException!';
    }

    if (e is StateError) {
      return e.message;
    }

    return 'Something went wrong!';
  }
}
