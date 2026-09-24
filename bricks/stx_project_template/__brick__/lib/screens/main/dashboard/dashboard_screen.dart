import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/core/index.dart';
import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';

@RoutePage()
class const DashboardScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        ),
      ),
    );
  }
}
