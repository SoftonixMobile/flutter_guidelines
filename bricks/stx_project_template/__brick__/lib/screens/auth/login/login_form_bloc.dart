import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:{{project_name}}/core/index.dart';
import 'package:{{project_name}}/repositories/index.dart';

@Injectable(scope: 'auth')
class LoginFormBloc(final AuthRepository _authRepository)
    extends FormBloc<bool, String> {
  late final TextFieldBloc username;
  late final TextFieldBloc password;

  this : super(customSubmit: false) {
    username = TextFieldBloc(
      required: true,
      rules: {.onBlur},
    );

    password = TextFieldBloc(
      required: true,
      customValidators: {FieldValidators.passwordMin6Chars},
      rules: {.onBlur},
    );

    addFields([
      username,
      password,
    ]);
  }

  @override
  FutureOr<void> onSubmit() async {
    await _authRepository.signIn(
      username.toString(),
      password.toString(),
    );

    emitSuccess(true);
  }
}
