import 'dart:math';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{project_name}}/services/index.dart';
import 'package:{{project_name}}/styles/index.dart';
import 'package:{{project_name}}/widgets/index.dart';
import 'login_form_bloc.dart';
import 'widgets/index.dart';

class LoginScreen extends StatefulWidget implements AutoRouteWrapper {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LoginFormBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final mainContainerWidth = screenSize.width * 0.85;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        color: Colors.lightBlue,
        child: SingleChildScrollView(
          child: SizedBox(
            height: max(screenSize.height, 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomCard(
                  width: mainContainerWidth,
                  height: 450,
                  slotWidget: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Assets.images.logo.image(
                          width: 180,
                          height: 90,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const LoginForm(),
                      const Spacer()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
