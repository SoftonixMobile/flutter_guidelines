import 'package:data_provider/network.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';
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
  final userData = UserData(userProfile: const UserProfile());
  final httpClient = HttpClient(logger: logger);

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<UserData>(userData)
    ..registerSingleton<AuthSession>(httpClient)
    ..registerSingleton<NetworkBaseClient>(httpClient)
    ..registerFactory(() => AuthService(httpClient))
    ..registerFactory(() => UserService(httpClient))
    ..initAuthScope();
}

//register other dependencies (except auth ones)
Future<void> configureUserDependencies(GetIt getIt) {
  return getIt.init();
}
