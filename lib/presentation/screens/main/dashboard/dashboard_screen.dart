import 'package:flutter/material.dart';

import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'package:flutter_guidelines/presentation/utils/index.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typographyTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(LocaleKeys.dashboard)),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => RootScaffold.openEndDrawer(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.tr(LocaleKeys.dashboardScreenTitle),
          style: typography.bodyLarge,
        ),
      ),
    );
  }
}
