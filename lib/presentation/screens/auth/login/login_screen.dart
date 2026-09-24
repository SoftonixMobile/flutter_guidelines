import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';

import 'login_form_bloc.dart';
import 'widgets/index.dart';

@RoutePage()
class const LoginScreen({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginFormBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorsTheme;

    final screenSize = MediaQuery.sizeOf(context);
    final mainContainerWidth = screenSize.width * 0.85;

    return CustomFormBlocListener<LoginFormBloc, bool>(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: double.infinity,
          color: colors.primary,
          child: SingleChildScrollView(
            child: SizedBox(
              height: max(screenSize.height, 600),
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  CustomCard(
                    width: mainContainerWidth,
                    height: 450,
                    child: Column(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Container(
                          margin: const .only(top: 10),
                          child: Assets.images.logo.image(
                            width: 180,
                            height: 90,
                            fit: .contain,
                          ),
                        ),
                        const LoginForm(),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
