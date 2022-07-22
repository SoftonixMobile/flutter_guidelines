import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/styles/index.dart';

class CustomTabsRouter extends StatelessWidget {
  const CustomTabsRouter({
    Key? key,
    required this.appBarTitle,
    required this.tabs,
    required this.routes,
  }) : super(key: key);

  final String appBarTitle;
  final List<String> tabs;
  final List<PageRouteInfo<dynamic>> routes;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: routes,
      builder: (context, child, animation) {
        return DefaultTabController(
          length: tabs.length,
          initialIndex: context.tabsRouter.activeIndex,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                title: Text(appBarTitle),
                elevation: 0,
                bottom: TabBar(
                  tabs: _buildTabs(tabs),
                  onTap: context.tabsRouter.setActiveIndex,
                  isScrollable: true,
                  indicatorWeight: 0.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: MaterialIndicator(
                    height: 5,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    tabPosition: TabPosition.bottom,
                    color: AppColors.white,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => RootScaffold.openDrawer(context),
                ),
              ),
            ],
            body: FadeTransition(
              opacity: animation,
              child: child,
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildTabs(List<String> tabs) {
    return tabs.map((tab) => Tab(text: tab, height: 46)).toList();
  }
}
