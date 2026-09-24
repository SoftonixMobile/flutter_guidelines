import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';

import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/services/index.dart';
import 'package:{{project_name}}/theme/index.dart';
import 'package:{{project_name}}/widgets/index.dart';

import 'app_state_wrapper.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}}App({super.key}) extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getAppTheme(context),
        builder: (context, child) {
          // Maps `material_ui` theme and localizations for dependencies
          //  that still use `package:flutter/material.dart`.
          // ignore: deprecated_member_use
          return MaterialUiCompatibilityBridge(
            child: AppUpgraderDialog(
              navigatorKey: _appRouter.navigatorKey,
              child: child,
            ),
          );
        },
        routerConfig: _appRouter.config(
          navigatorObservers: () => [
            RouterObserver(LoggerService.instance),
            AutoRouteObserver(),
          ],
        ),
        localizationsDelegates: [
          ...context.localizationDelegates,
          ...GlobalMaterialLocalizations.delegates,
        ],
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
