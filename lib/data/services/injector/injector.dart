import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/core/router/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
//register only auth dependencies
void configureAuthDependencies() {
  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(LoggerService.instance)
    ..initAuthScope();
}

//register other dependencies (except auth ones)
void configureUserDependencies(GetIt getIt) {
  getIt.init();
}
