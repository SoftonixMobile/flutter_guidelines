import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:{{project_name}}/core/helpers/index.dart';
import 'package:{{project_name}}/styles/index.dart';

class CustomTabsRouter extends StatelessWidget {
  const CustomTabsRouter({
    super.key,
    required this.appBarTitle,
    required this.tabs,
    required this.routes,
  });

  final String appBarTitle;
  final List<String> tabs;
  final List<PageRouteInfo<dynamic>> routes;

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: routes,
      builder: (context, child) {
        return DefaultTabController(
          length: tabs.length,
          initialIndex: context.tabsRouter.activeIndex,
          child: ExtendedNestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: true,
                title: Text(appBarTitle),
                elevation: 0,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: _buildTabs(tabs),
                  onTap: context.tabsRouter.setActiveIndex,
                  isScrollable: true,
                  indicatorWeight: 0,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: MaterialIndicator(
                    height: 5,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    color: AppColors.white,
                  ),
                  tabAlignment: TabAlignment.center,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => RootScaffold.openEndDrawer(context),
                  ),
                ],
              ),
            ],
            onlyOneScrollInBody: true,
            body: child,
          ),
        );
      },
    );
  }

  List<Widget> _buildTabs(List<String> tabs) {
    return tabs.map((tab) => Tab(text: tab, height: 46)).toList();
  }
}
