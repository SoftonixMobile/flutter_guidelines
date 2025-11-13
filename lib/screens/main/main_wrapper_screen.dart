import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'main_state_wrapper.dart';

@RoutePage(name: 'MainRouter')
class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  @override
  void initState() {
    super.initState();

    getIt.pushNewScope(init: configureUserDependencies);
  }

  @override
  void dispose() {
    unawaited(getIt.popScope());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MainStateWrapper(child: AutoRouter());
  }
}
