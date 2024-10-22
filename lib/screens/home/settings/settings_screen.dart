import 'package:flutter/material.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/router/index.dart';

export 'pages/index.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.settings)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => RootScaffold.openEndDrawer(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.tr(LocaleKeys.settingsScreenTitle),
        ),
      ),
    );
  }
}
