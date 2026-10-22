import 'package:data_provider/injector.dart';
import 'package:data_provider/network.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_storage/secure_storage.dart';

import 'package:flutter_guidelines/core/config/app_config.dart';
import 'package:flutter_guidelines/core/logger/logger.dart';
import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/presentation/router/index.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
//register app-wide dependencies
Future<void> configureAppDependencies({
  required Logger logger,
}) async {
  final apiClient = DioApiClient(
    baseUrl: AppConfig.appApiUrl,
    storage: const SecureStorage(),
  );

  getIt
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<ApiClient>(apiClient);

  await DataProviderPackageModule().init(GetItHelper(getIt));

  getIt.initAppScope();
}

//register user-scoped dependencies (except app-wide ones)
void configureUserDependencies(GetIt getIt) {
  final userData = UserData(userProfile: const UserProfile());

  getIt
    ..registerSingleton(userData)
    ..init();
}
