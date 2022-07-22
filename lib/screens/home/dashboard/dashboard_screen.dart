import 'package:flutter/material.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/localization/index.dart';

export 'pages/index.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.dashboard.tr()),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => RootScaffold.openDrawer(context),
        ),
      ),
      body: Center(
        child: Text(
          LocaleKeys.dashboardScreenTitle.tr(),
        ),
      ),
    );
  }
}
