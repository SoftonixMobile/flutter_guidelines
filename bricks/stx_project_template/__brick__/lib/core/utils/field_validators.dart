// ignore_for_file: avoid_positional_boolean_parameters

abstract final class FieldValidators {
  static final _emailRegExp = RegExp(
    r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
  );

  static const _requiredErrorMessage = 'Field is required';
  static const _emailErrorMessage = 'Email is invalid';
  static const _passwordMin6CharsErrorMessage =
      'Password length must be at least 6 characters';

  static String? required(dynamic value) {
    final isEmpty = switch (value) {
      String() => value.isEmpty,
      Iterable() => value.isEmpty,
      Map() => value.isEmpty,
      null => true,
      _ => false,
    };

    return isEmpty ? _requiredErrorMessage : null;
  }

  static String? booleanRequired(bool? value) {
    return (value ?? false) ? null : _requiredErrorMessage;
  }

  static String? email(String? value) {
    final hasEmailFormat = _emailRegExp.hasMatch(value ?? '');

    return hasEmailFormat ? null : _emailErrorMessage;
  }

  static String? passwordMin6Chars(String? value) {
    final hasMin6Chars = (value ?? '').length >= 6;

    return hasMin6Chars ? null : _passwordMin6CharsErrorMessage;
  }
}
