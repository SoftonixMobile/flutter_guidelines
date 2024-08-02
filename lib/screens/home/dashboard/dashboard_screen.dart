import 'package:flutter/material.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/theme/app_theme.dart';
import 'package:flutter_guidelines/widgets/index.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    final theme = AppTheme.of(context);
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        title: AppText.subhead1(LocaleKeys.dashboard.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => RootScaffold.openEndDrawer(context),
          ),
        ],
      ),
      body: Center(
        child: AppText.body1(
          LocaleKeys.dashboardScreenTitle.tr(),
        ),
      ),
    );
  }
}
