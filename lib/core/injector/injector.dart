import 'package:data_provider/injector.dart';
import 'package:data_provider/network.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/core/logger/index.dart';
import 'package:flutter_guidelines/core/router/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  includeMicroPackages: false,
)
//register only auth dependencies
void configureAuthDependencies({
  required Logger logger,
}) {
  final httpClient = HttpClient(logger: logger);

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<AuthSession>(httpClient)
    ..registerSingleton<ApiClient>(httpClient)
    ..registerFactory(() => AuthService(httpClient))
    ..registerFactory(() => UserService(httpClient))
    ..initAuthScope();
}

//register other dependencies (except auth ones)
void configureUserDependencies(
  GetIt getIt, {
  UserProfile userProfile = const UserProfile(),
}) {
  // ignore: discarded_futures
  DataProviderPackageModule().init(GetItHelper(getIt));

  getIt
    ..registerSingleton<UserData>(.new(userProfile: userProfile))
    ..init();
}
