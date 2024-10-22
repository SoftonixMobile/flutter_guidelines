import 'package:flutter/material.dart';

import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      endDrawer: const AppDrawer(),
      routes: const [
        DashboardRoute(),
        MessagesRoute(),
        SettingsRoute(),
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
                label: context.tr(LocaleKeys.dashboard),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.message),
                label: context.tr(LocaleKeys.messages),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: context.tr(LocaleKeys.settings),
              ),
            ],
          ),
        );
      },
    );
  }
}
