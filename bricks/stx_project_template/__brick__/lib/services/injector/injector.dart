import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/router/index.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
)
//register only auth dependencies
void configureAuthDependencies() {
  getIt
    ..registerSingleton(AppRouter())
    ..initAuthScope();
}

//register other dependencies (except auth ones)
void configureUserDependencies(GetIt getIt) {
  getIt.init();
}
