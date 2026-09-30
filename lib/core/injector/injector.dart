import 'package:data_provider/injector.dart';
import 'package:data_provider/network.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_storage/secure_storage.dart';

import 'package:flutter_guidelines/core/config/app_config.dart';
import 'package:flutter_guidelines/core/logger/logger.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
//register only auth dependencies
void configureAuthDependencies({
  required Logger logger,
}) {
  final userData = UserData(userProfile: const UserProfile());
  final apiClient = DioApiClient(
    baseUrl: AppConfig.appApiUrl,
    storage: const SecureStorage(),
  );

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<UserData>(userData)
    ..registerSingleton<ApiClient>(apiClient)
    ..registerFactory(() => AuthService(apiClient))
    ..registerFactory(() => SessionService(apiClient))
    ..registerFactory(() => UserService(apiClient))
    ..initAuthScope();
}

//register other dependencies (except auth ones)
void configureUserDependencies(GetIt getIt) {
  // ignore: discarded_futures
  DataProviderPackageModule().init(GetItHelper(getIt));

  getIt.init();
}
