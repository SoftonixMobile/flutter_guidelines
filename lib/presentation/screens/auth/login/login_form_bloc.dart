import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/domain/repositories/index.dart';

// TODO(Vova): add validators
@Injectable(scope: 'auth')
class LoginFormBloc extends FormBloc<bool, String> {
  late final TextFieldBloc username;
  late final TextFieldBloc password;

  final AuthRepository _authRepository;

  LoginFormBloc(this._authRepository) : super(customSubmit: false) {
    username = TextFieldBloc(
      required: true,
      rules: {ValidationType.onBlur},
    );

    password = TextFieldBloc(
      required: true,
      // Will be changed later
      // ignore: deprecated_member_use
      customValidators: {FieldBlocValidators.passwordMin6Chars},
      rules: {ValidationType.onBlur},
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
