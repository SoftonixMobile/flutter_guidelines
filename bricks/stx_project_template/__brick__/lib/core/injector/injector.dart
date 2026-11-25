import 'package:api_client/api_client.dart';
import 'package:app_api/injector.dart';
import 'package:app_api/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:persistent_storage/persistent_storage.dart';
import 'package:secure_storage/secure_storage.dart';

import 'package:{{project_name}}/core/config/app_config.dart';
import 'package:{{project_name}}/core/logger/logger.dart';
import 'package:{{project_name}}/domain/models/index.dart';
import 'package:{{project_name}}/presentation/router/index.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
//register app-wide dependencies
Future<void> configureAppDependencies({
  required AppConfig config,
  required Logger logger,
}) async {
  final baseUrl = config.apiUrl.toString();
  final authSession = DioAuthSession(
    baseUrl: baseUrl,
    storage: const SecureStorage(),
    tokenRefresher: AuthTokenRefresher.refresh,
  );
  final apiClient = DioApiClient(baseUrl: baseUrl, authSession: authSession);

  getIt
    ..registerSingleton(config)
    ..registerSingleton(AppRouter())
    ..registerSingleton<Logger>(logger)
    ..registerSingleton<AuthSession>(authSession)
    ..registerSingleton<ApiClient>(apiClient)
    ..registerSingleton(PersistentStorage());

  await AppApiPackageModule().init(GetItHelper(getIt));

  getIt.initAppScope();
}

//register user-scoped dependencies (except app-wide ones)
void configureUserDependencies(GetIt getIt) {
  final userData = UserData(userProfile: const UserProfile());

  getIt
    ..registerSingleton(userData)
    ..init();
}
