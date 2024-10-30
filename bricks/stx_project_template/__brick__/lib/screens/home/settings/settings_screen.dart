import 'package:flutter/material.dart';

import 'package:{{project_name}}/core/index.dart';
import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';

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
