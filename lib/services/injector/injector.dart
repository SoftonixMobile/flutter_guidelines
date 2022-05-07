import 'package:flutter_guidelines/router/index.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  asExtension: true,
  initializerName: 'init',
)
void configureDependencies() {
  getIt.init();
  getIt.registerSingleton(AppRouter());
}
