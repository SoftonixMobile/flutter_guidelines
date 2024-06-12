import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:{{project_name}}/blocs/index.dart';
import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/services/index.dart';

@RoutePage()
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void _removeSplashScreen() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          LoggerService.instance.registerUserProfile(state.userProfile);
        }
      },
      builder: (context, state) {
        return AutoRouter.declarative(
          routes: (_) {
            switch (state.status) {
              case AuthStatus.initial:
                return [];
              case AuthStatus.unauthenticated:
                _removeSplashScreen();
                return [const LoginRoute()];
              case AuthStatus.authenticated:
                _removeSplashScreen();
                return [const HomeRouter()];
            }
          },
        );
      },
    );
  }
}
