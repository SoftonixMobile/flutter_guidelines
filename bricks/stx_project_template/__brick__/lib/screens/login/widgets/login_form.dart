import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{project_name}}/screens/login/widgets/index.dart';
import 'package:{{project_name}}/styles/index.dart';
import 'package:{{project_name}}/widgets/index.dart';
import '../login_form_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<LoginFormBloc>();

    return Column(
      children: <Widget>[
        TextInputFormBuilder(
          label: 'Username',
          fieldBloc: formBloc.username,
        ),
        TextInputFormBuilder(
          isObscureText: true,
          label: 'Password',
          fieldBloc: formBloc.password,
        ),
        Container(
          margin: const EdgeInsets.only(top: 14, bottom: 10),
          child: LoginButton(
            onPressed: () => context.read<LoginFormBloc>().submit(),
          ),
        ),
      ],
    );
  }
}
