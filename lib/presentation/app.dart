import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_guidelines/core/index.dart';

import 'blocs/index.dart';
import 'localization/index.dart';
import 'router/index.dart';
import 'theme/index.dart';
import 'widgets/index.dart';

class FlutterGuidelinesApp({super.key}) extends StatelessWidget {
  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return _AppStateWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        builder: (context, child) {
          // Provides Theme and MaterialLocalizations to dependencies that
          //  still use package:flutter/material.dart (upgrader, form dialogs).
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
            RouterObserver(getIt<Logger>()),
            AutoRouteObserver(),
          ],
        ),
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
      ),
    );
  }
}

class const _AppStateWrapper({
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: getIt<AppConfig>(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<LocaleCubit>(),
          ),
          BlocProvider(
            create: (context) =>
                getIt<SessionBloc>()..add(const SessionEvent.subscribe()),
          ),
        ],
        child: child,
      ),
    );
  }
}
