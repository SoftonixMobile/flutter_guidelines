import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'field_errors.dart';

abstract final class FieldValidators() {
  static final _emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );

  static String? required(dynamic value) {
    final isEmpty = switch (value) {
      String() => value.isEmpty,
      Iterable() => value.isEmpty,
      Map() => value.isEmpty,
      null => true,
      _ => false,
    };

    return isEmpty ? const RequiredError().encode() : null;
  }

  static String? booleanRequired(bool? value) {
    return (value ?? false) ? null : const RequiredError().encode();
  }

  static String? email(String? value) {
    final hasEmailFormat = _emailRegExp.hasMatch(value ?? '');

    return hasEmailFormat ? null : const EmailError().encode();
  }

  static Validator<String?> minLength(int min) {
    return (value) =>
        (value ?? '').length >= min ? null : MinLengthError(min).encode();
  }

  static Validator<String?> maxLength(int max) {
    return (value) =>
        (value ?? '').length <= max ? null : MaxLengthError(max).encode();
  }
}
