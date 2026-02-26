import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_guidelines/presentation/router/index.dart';
import '../blocs/auth/auth_bloc.dart';

@RoutePage()
class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  void _removeSplashScreen() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status != .initial) {
          _removeSplashScreen();
        }

        return AutoRouter.declarative(
          routes: (_) {
            return switch (state.status) {
              .initial => const [],
              .unauthenticated => const [LoginRoute()],
              .authenticated => const [MainRouter()],
            };
          },
        );
      },
    );
  }
}
