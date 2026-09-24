import 'dart:async';

import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/services/index.dart';

import 'main_state_wrapper.dart';

@RoutePage(name: 'MainRouter')
class const MainWrapperScreen({super.key}) extends StatefulWidget {
  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState() extends State<MainWrapperScreen> {
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
