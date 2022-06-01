import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/screens/login/widgets/index.dart';
import 'package:flutter_guidelines/styles/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';
import '../login_form_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.usernameFocusNode,
    required this.passwordFocusNode,
    Key? key,
  }) : super(key: key);

  final FocusNode usernameFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<LoginFormBloc>();

    return CustomFormBlocListener<LoginFormBloc, String>(
      formBloc: formBloc,
      onSuccess: (context, state) {
        context.read<AuthBloc>().authDataChanged(state.response!);
      },
      child: Column(
        children: <Widget>[
          TextInputFormBuilder(
            label: 'Username',
            fieldBloc: formBloc.username,
            fieldFocusNode: usernameFocusNode,
            nextFieldFocusNode: passwordFocusNode,
          ),
          TextInputFormBuilder(
            isObscureText: true,
            label: 'Password',
            fieldBloc: formBloc.password,
            fieldFocusNode: passwordFocusNode,
            onSubmit: () => _submit(context),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 14,
              bottom: 10,
            ),
            child: LoginButton(
              onPressed: () => _submit(context),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.only(right: 10),
            child: const Text(
              'Reset password',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    usernameFocusNode.unfocus();
    passwordFocusNode.unfocus();
    context.read<LoginFormBloc>().submit();
  }
}
