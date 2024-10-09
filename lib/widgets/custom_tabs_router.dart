import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';

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
    final colors = context.theme.colors;

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
                backgroundColor: colors.background,
                title: AppText.subhead1(
                  appBarTitle,
                ),
                elevation: 0,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: _buildTabs(tabs),
                  labelColor: colors.primary,
                  unselectedLabelColor: colors.foreground,
                  onTap: context.tabsRouter.setActiveIndex,
                  isScrollable: true,
                  indicatorWeight: 0,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: MaterialIndicator(
                    height: 5,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    color: colors.primary,
                  ),
                  tabAlignment: TabAlignment.center,
                ),
                actions: [
                  IconButton(
                    color: colors.foreground,
                    icon: const Icon(
                      Icons.menu,
                    ),
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
