import 'package:flutter/material.dart';

import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return AutoTabsScaffold(
      endDrawer: const AppDrawer(),
      routes: const [
        DashboardRouter(),
        MessagesRouter(),
        SettingsRouter(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.dashboard),
                label: LocaleKeys.dashboard.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.message),
                label: LocaleKeys.messages.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: LocaleKeys.settings.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
