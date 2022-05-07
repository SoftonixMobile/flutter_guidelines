import 'package:flutter/material.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
