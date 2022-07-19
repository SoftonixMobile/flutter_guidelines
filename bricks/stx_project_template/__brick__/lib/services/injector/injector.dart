import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/router/index.dart';
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
