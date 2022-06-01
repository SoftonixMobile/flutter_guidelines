import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/screens/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authStatus = context.watch<AuthBloc>().state.status;

    return AutoRouter.declarative(
      routes: (context) {
        switch (authStatus) {
          case AuthStatus.initial:
            return [];
          case AuthStatus.unauthenticated:
            FlutterNativeSplash.remove();
            return [const LoginRoute()];
          case AuthStatus.authenticated:
            FlutterNativeSplash.remove();
            return [const HomeRoute()];
        }
      },
    );
  }
}
