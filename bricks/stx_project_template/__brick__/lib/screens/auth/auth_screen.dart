import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:provider/provider.dart';

import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/screens/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthBloc>().state.status;

    return AutoRouter.declarative(
      routes: (context) {
        switch (authStatus) {
          case AuthenticationStatus.initial:
            return [];
          case AuthenticationStatus.unauthenticated:
            FlutterNativeSplash.remove();
            return [const LoginRoute()];
          case AuthenticationStatus.authenticated:
            FlutterNativeSplash.remove();
            return [const HomeRoute()];
        }
      },
    );
  }
}
