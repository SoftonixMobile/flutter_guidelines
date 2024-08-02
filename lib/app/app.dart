import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/theme/app_theme.dart' as custom_theme;
import 'package:flutter_guidelines/theme/data/theme_data.dart';
import 'app_state_wrapper.dart';

class SwitchProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  void changeTheme(bool newValue) {
    isDarkTheme = newValue;

    notifyListeners();
  }
}

class FlutterGuidelines extends StatelessWidget {
  FlutterGuidelines({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SwitchProvider(),
      child: Builder(
        builder: (context) {
          final provider = context.watch<SwitchProvider>();

          return AppStateWrapper(
            child: custom_theme.AppTheme(
              data: provider.isDarkTheme
                  ? AppThemeData.regular().copyWith.colors(
                        foreground: Colors.white,
                        background: Colors.black,
                      )
                  : AppThemeData.regular(),
              child: Builder(
                builder: (context) {
                  return WidgetsApp.router(
                    debugShowCheckedModeBanner: false,
                    color: custom_theme.AppTheme.of(context).colors.primary,
                    routerConfig: _appRouter.config(
                      navigatorObservers: () =>
                          [RouterObserver(LoggerService.instance)],
                    ),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
