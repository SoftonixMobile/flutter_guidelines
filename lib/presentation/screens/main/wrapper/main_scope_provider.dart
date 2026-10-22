import 'dart:async';

import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/index.dart';

class const MainScopeProvider({
  super.key,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<MainScopeProvider> createState() => _MainScopeProviderState();
}

class _MainScopeProviderState() extends State<MainScopeProvider> {
  static const _scopeName = 'user';

  @override
  void initState() {
    super.initState();

    getIt.pushNewScope(
      scopeName: _scopeName,
      init: configureUserDependencies,
    );
  }

  @override
  void dispose() {
    unawaited(getIt.dropScope(_scopeName));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
