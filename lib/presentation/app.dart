import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/core/router/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/presentation/theme/index.dart';
import 'package:flutter_guidelines/presentation/widgets/index.dart';
import 'blocs/auth/auth_bloc.dart';

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
          navigatorObservers: () => [
            RouterObserver(LoggerService.instance),
            AutoRouteObserver(),
          ],
        ),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}

class AppStateWrapper extends StatelessWidget {
  const AppStateWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
      ],
      child: child,
    );
  }
}
