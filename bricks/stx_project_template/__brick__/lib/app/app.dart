import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:{{project_name}}/router/index.dart';
import 'package:{{project_name}}/services/index.dart';
import 'package:{{project_name}}/styles/index.dart';
import 'app_state_wrapper.dart';

class {{#pascalCase}}{{project_name}}{{/pascalCase}} extends StatelessWidget {
  {{#pascalCase}}{{project_name}}{{/pascalCase}}({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getAppTheme(context),
        routerConfig: _appRouter.config(
          navigatorObservers: () => [RouterObserver(LoggerService.instance)],
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
