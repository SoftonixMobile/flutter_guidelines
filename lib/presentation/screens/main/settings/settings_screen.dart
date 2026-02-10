import 'package:flutter/material.dart';

import 'package:flutter_guidelines/core/localization/index.dart';
import 'package:flutter_guidelines/core/router/index.dart';
import 'package:flutter_guidelines/presentation/helpers/index.dart';

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
