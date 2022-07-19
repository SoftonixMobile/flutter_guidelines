import 'package:flutter/material.dart';

import 'package:{{project_name}}/localization/index.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/widgets/index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EasyLocalization.of(context);

    final tabs = [
      LocaleKeys.profileInfo.tr(),
      LocaleKeys.profileDocuments.tr(),
    ];

    const routes = [
      InfoRoute(),
      DocumentsRoute(),
    ];

    return SliverTabsRouter(
      appBarTitle: LocaleKeys.profile.tr(),
      tabs: tabs,
      routes: routes,
    );
  }
}
