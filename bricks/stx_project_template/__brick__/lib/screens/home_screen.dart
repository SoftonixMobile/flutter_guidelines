import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return AutoTabsScaffold(
      drawer: const AppDrawer(),
      routes: const [
        ProfileRoute(),
        PostsRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return Container(
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
                icon: const Icon(Icons.verified_user),
                label: LocaleKeys.profile.tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.group),
                label: LocaleKeys.posts.tr(),
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
