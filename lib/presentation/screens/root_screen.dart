import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/router/index.dart';

import '../blocs/session/session_bloc.dart';

@RoutePage()
class const RootScreen({super.key}) extends StatelessWidget {
  void _removeSplashScreen() {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        if (state.authStatus != .initial) {
          _removeSplashScreen();
        }

        return AutoRouter.declarative(
          routes: (_) {
            return switch (state.authStatus) {
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
