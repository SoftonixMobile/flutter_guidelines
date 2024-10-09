import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:flutter_guidelines/router/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_guidelines/theme/index.dart';
import 'app_state_wrapper.dart';

class SwitchProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  // ignore: avoid_positional_boolean_parameters
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
          context.watch<SwitchProvider>();

          return AppStateWrapper(
            child: Builder(
              builder: (context) {
                return MaterialApp.router(
                  theme: AppTheme.getAppTheme(context),
                  debugShowCheckedModeBanner: false,
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
          );
        },
      ),
    );
  }
}
