import 'package:flutter/foundation.dart';

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
  externalPackageModulesBefore: [
    ExternalModule(DataProviderPackageModule),
  ],
)
//register only auth dependencies
Future<void> configureAuthDependencies() async {
  final logger = await _configureLogger();
  final httpClient = HttpClient(logger: logger);

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<AuthSession>(httpClient)
    ..registerSingleton<NetworkBaseClient>(httpClient)
    ..registerFactory(() => AuthService(httpClient))
    ..registerFactory(() => UserService(httpClient))
    ..initAuthScope();
}

Future<Logger> _configureLogger() async {
  final logger = MultiLogger([
    if (kDebugMode) ConsoleLogger(),
  ]);
  await logger.init();

  return logger;
}

//register other dependencies (except auth ones)
Future<void> configureUserDependencies(
  GetIt getIt, {
  UserProfile userProfile = const UserProfile(),
}) async {
  getIt.registerSingleton<UserData>(.new(userProfile: userProfile));

  await getIt.init();
}
