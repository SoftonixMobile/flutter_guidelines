import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:{{project_name}}/app_state_wrapper.dart';
import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/services/index.dart';
import 'package:{{project_name}}/styles/index.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}} extends StatelessWidget {
  {{#pascalCase}}{{project_name}}{{/pascalCase}}({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: '{{#titleCase}}{{project_name}}{{/titleCase}}',
        theme: AppTheme.getAppTheme(context),
        routerDelegate: _appRouter.delegate(
          navigatorObservers: () => [RouterObserver()],
        ),
        routeInformationParser: _appRouter.defaultRouteParser(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
