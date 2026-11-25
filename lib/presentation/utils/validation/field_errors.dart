import 'package:flutter_guidelines/presentation/localization/index.dart';

import 'field_error.dart';

final class const RequiredError() extends FieldError {
  @override
  String get code => 'required';

  @override
  String localize(Translations tr) => tr.common.validators.required;
}

final class const EmailError() extends FieldError {
  @override
  String get code => 'email';

  @override
  String localize(Translations tr) => tr.common.validators.email;
}

final class const MinLengthError(final int min) extends FieldError {
  @override
  String get code => 'minLength:$min';

  @override
  String localize(Translations tr) => tr.common.validators.minLength(min: min);
}

final class const MaxLengthError(final int max) extends FieldError {
  @override
  String get code => 'maxLength:$max';

  @override
  String localize(Translations tr) => tr.common.validators.maxLength(max: max);
}
