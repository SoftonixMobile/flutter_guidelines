//@GeneratedMicroModule;DataProviderPackageModule;package:data_provider/src/injector/inject_package.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:data_provider/network.dart' as _i164;
import 'package:data_provider/src/services/auth_service.dart' as _i915;
import 'package:data_provider/src/services/chats_service.dart' as _i1034;
import 'package:data_provider/src/services/posts_service.dart' as _i576;
import 'package:data_provider/src/services/user_service.dart' as _i23;
import 'package:injectable/injectable.dart' as _i526;

class DataProviderPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.factory<_i915.AuthService>(
        () => _i915.AuthService(gh<_i164.ApiClient>()));
    gh.factory<_i1034.ChatsService>(
        () => _i1034.ChatsService(gh<_i164.ApiClient>()));
    gh.factory<_i576.PostsService>(
        () => _i576.PostsService(gh<_i164.ApiClient>()));
    gh.factory<_i23.UserService>(() => _i23.UserService(gh<_i164.ApiClient>()));
  }
}
