import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/state_wrapper.dart';
import 'package:flutter_guidelines/styles/index.dart';

class SoftonixApp extends StatelessWidget {
  SoftonixApp({Key? key}) : super(key: key);

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return StateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.themeData,
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
