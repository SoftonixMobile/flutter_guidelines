// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'dart:async' as _i687;

import 'package:api_client/api_client.dart' as _i633;
import 'package:app_api/src/services/auth_service.dart' as _i996;
import 'package:app_api/src/services/chats_service.dart' as _i949;
import 'package:app_api/src/services/posts_service.dart' as _i332;
import 'package:app_api/src/services/session_service.dart' as _i742;
import 'package:app_api/src/services/user_service.dart' as _i422;
import 'package:injectable/injectable.dart' as _i526;

class AppApiPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i742.SessionService>(
      () => _i742.SessionService(gh<_i633.AuthSession>()),
    );
    gh.factory<_i996.AuthService>(
      () => _i996.AuthService(gh<_i633.ApiClient>()),
    );
    gh.factory<_i949.ChatsService>(
      () => _i949.ChatsService(gh<_i633.ApiClient>()),
    );
    gh.factory<_i332.PostsService>(
      () => _i332.PostsService(gh<_i633.ApiClient>()),
    );
    gh.factory<_i422.UserService>(
      () => _i422.UserService(gh<_i633.ApiClient>()),
    );
  }
}
