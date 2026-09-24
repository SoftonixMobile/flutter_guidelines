import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/screens/auth/login/widgets/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';

import '../login_form_bloc.dart';

class const LoginForm({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<LoginFormBloc>();

    return Column(
      children: <Widget>[
        TextInputFormField(
          key: const Key('username'),
          label: 'Username',
          fieldBloc: formBloc.username,
        ),
        TextInputFormField(
          key: const Key('password'),
          label: 'Password',
          isObscureText: true,
          fieldBloc: formBloc.password,
        ),
        Container(
          margin: const .only(top: 14, bottom: 10),
          child: LoginButton(
            onPressed: context.read<LoginFormBloc>().submit,
          ),
        ),
      ],
    );
  }
}
