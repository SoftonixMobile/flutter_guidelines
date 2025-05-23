import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:{{project_name}}/repositories/auth_repository.dart';

@Injectable(scope: 'auth')
class LoginFormBloc extends FormBloc<String, String> {
  late final TextFieldBloc username;
  late final TextFieldBloc password;

  final AuthRepository authRepository;

  LoginFormBloc({
    required this.authRepository,
  }) : super(customSubmit: false) {
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
    await authRepository.signIn(username.toString(), password.toString());

    emitSuccess('Success');
  }
}
