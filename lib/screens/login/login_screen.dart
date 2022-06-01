import 'dart:math';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/styles/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';
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
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
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
                      Builder(builder: (context) {
                        return LoginForm(
                          usernameFocusNode: _usernameFocusNode,
                          passwordFocusNode: _passwordFocusNode,
                        );
                      }),
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
