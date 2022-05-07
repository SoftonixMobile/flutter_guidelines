import 'dart:async';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/screens/auth/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:stx_form_bloc/stx_form_bloc.dart';

@injectable
class LoginFormBloc extends FormBloc<String, String> {
  late TextFieldBloc username;
  late TextFieldBloc password;

  final AuthBloc authBloc;
  final AuthRepository repository;

  LoginFormBloc({
    required this.authBloc,
    required this.repository,
  }) : super() {
    username = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
      ],
      rules: [ValidationType.onBlur],
    );

    password = TextFieldBloc(
      validators: [
        FieldBlocValidators.required,
        FieldBlocValidators.passwordMin6Chars
      ],
      rules: [ValidationType.onBlur],
    );

    addFields([
      username,
      password,
    ]);
  }

  @override
  FutureOr<void> onSubmit() async {
    try {
      final authData = await repository.login(username.value, password.value);

      emitSuccess(authData);
    } catch (e) {
      emitFailure('Something went wrong!');
    }
  }
}
