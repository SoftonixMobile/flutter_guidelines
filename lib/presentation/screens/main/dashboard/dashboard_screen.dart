import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'package:flutter_guidelines/presentation/utils/index.dart';

@RoutePage()
class const DashboardScreen({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typography = context.theme.typographyTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => RootScaffold.openEndDrawer(context),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Dashboard Screen',
          style: typography.bodyLarge,
        ),
      ),
    );
  }
}
