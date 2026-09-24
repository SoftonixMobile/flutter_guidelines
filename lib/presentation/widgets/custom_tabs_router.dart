import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'package:flutter_guidelines/presentation/router/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'package:flutter_guidelines/presentation/utils/index.dart';

class const CustomTabsRouter({
  super.key,
  required final String appBarTitle,
  required final List<String> tabs,
  required final List<PageRouteInfo<dynamic>> routes,
}) extends StatelessWidget {
  List<Widget> _buildTabs(List<String> tabs) {
    return tabs.map((tab) => Tab(text: tab, height: 46)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colorsTheme;

    return AutoTabsRouter(
      routes: routes,
      builder: (context, child) {
        return DefaultTabController(
          length: tabs.length,
          initialIndex: context.tabsRouter.activeIndex,
          child: ExtendedNestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
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
                  indicatorSize: .label,
                  indicator: MaterialIndicator(
                    height: 5,
                    topLeftRadius: 8,
                    topRightRadius: 8,
                    color: colors.primary,
                  ),
                  dividerColor: Colors.transparent,
                  tabAlignment: .center,
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
}
