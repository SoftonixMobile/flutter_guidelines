import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/styles/theme.dart' as material_theme;
import 'package:flutter_guidelines/theme/app_theme.dart' as custom_theme;
import 'package:flutter_guidelines/theme/data/theme_data.dart';
import 'app_state_wrapper.dart';

class FlutterGuidelines extends StatelessWidget {
  FlutterGuidelines({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return AppStateWrapper(
      child: custom_theme.AppTheme(
        data: AppThemeData.regular(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: material_theme.AppTheme.getAppTheme(context),
          routerConfig: _appRouter.config(
            navigatorObservers: () => [RouterObserver(LoggerService.instance)],
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}
