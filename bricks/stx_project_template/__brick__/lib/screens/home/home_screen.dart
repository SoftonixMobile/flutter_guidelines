import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:{{project_name}}/blocs/index.dart';
import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/services/index.dart';
import 'package:{{project_name}}/widgets/index.dart';

class HomeScreen extends StatelessWidget implements AutoRouteWrapper {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<ChatsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<PostsBloc>(),
        ),
      ],
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    return AutoTabsScaffold(
      drawer: const AppDrawer(),
      routes: const [
        DashboardRoute(),
        MessagesRoute(),
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
