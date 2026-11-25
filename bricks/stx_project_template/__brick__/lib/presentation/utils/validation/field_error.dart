import 'package:{{project_name}}/presentation/localization/index.dart';

abstract base class const FieldError() {
  static final _cache = <String, FieldError>{};

  static FieldError? decode(String? code) => _cache[code];

  /// Unique per error type and parameters
  String get code;

  String localize(Translations tr);

  /// Remembers this error so [decode] can find it and returns its [code].
  String encode() {
    _cache[code] = this;

    return code;
  }

  @override
  String toString() => code;
}
