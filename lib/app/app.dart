import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/styles/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';
import 'app_state_wrapper.dart';

class FlutterGuidelines extends StatelessWidget {
  FlutterGuidelines({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getAppTheme(context),
        builder: (context, child) {
          return AppUpgraderDialog(
            navigatorKey: _appRouter.navigatorKey,
            child: child,
          );
        },
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
