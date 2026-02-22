import 'package:data_provider/data_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/core/router/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  externalPackageModulesBefore: [
    ExternalModule(DataProviderPackageModule),
  ],
)
//register only auth dependencies
void configureAuthDependencies() {
  final logger = LoggerService.instance;
  final networkClient = HttpClient(logger: logger);

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<AuthSession>(networkClient)
    ..registerSingleton<NetworkBaseClient>(networkClient)
    ..registerFactory(() => AuthService(networkClient))
    ..registerFactory(() => UserService(networkClient))
    ..initAuthScope();
}

//register other dependencies (except auth ones)
Future<void> configureUserDependencies(GetIt getIt) {
  return getIt.init();
}
