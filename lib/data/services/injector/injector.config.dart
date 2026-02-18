// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:data_provider/data_provider.dart' as _i117;
import 'package:flutter_guidelines/data/repositories/auth_repository.dart'
    as _i776;
import 'package:flutter_guidelines/data/repositories/chats_repository.dart'
    as _i148;
import 'package:flutter_guidelines/data/repositories/index.dart' as _i44;
import 'package:flutter_guidelines/data/repositories/posts_repository.dart'
    as _i1049;
import 'package:flutter_guidelines/data/repositories/user_repository.dart'
    as _i365;
import 'package:flutter_guidelines/presentation/blocs/auth/auth_bloc.dart'
    as _i883;
import 'package:flutter_guidelines/presentation/screens/auth/login/login_form_bloc.dart'
    as _i175;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/chats/bloc/chats_bloc.dart'
    as _i440;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/posts/posts_bloc.dart'
    as _i521;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of auth-scope dependencies inside of GetIt
  _i174.GetIt initAuthScope({_i174.ScopeDisposeFunc? dispose}) {
    return _i526.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i526.GetItHelper gh) {
        gh.lazySingleton<_i365.UserRepository>(
          () => _i365.UserRepository(gh<_i117.UserService>()),
        );
        gh.lazySingleton<_i776.AuthRepository>(
          () => _i776.AuthRepository(gh<_i117.AuthService>()),
        );
        gh.factory<_i883.AuthBloc>(
          () => _i883.AuthBloc(
            gh<_i44.AuthRepository>(),
            gh<_i44.UserRepository>(),
          ),
        );
        gh.factory<_i175.LoginFormBloc>(
          () => _i175.LoginFormBloc(gh<_i44.AuthRepository>()),
        );
      },
    );
  }

  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    await _i117.DataProviderPackageModule().init(gh);
    gh.lazySingleton<_i1049.PostsRepository>(
      () => _i1049.PostsRepository(gh<_i117.PostsService>()),
    );
    gh.lazySingleton<_i148.ChatsRepository>(
      () => _i148.ChatsRepository(gh<_i117.ChatsService>()),
    );
    gh.factory<_i440.ChatsBloc>(
      () => _i440.ChatsBloc(gh<_i44.ChatsRepository>()),
    );
    gh.factory<_i521.PostsBloc>(
      () => _i521.PostsBloc(gh<_i44.PostsRepository>()),
    );
    return this;
  }
}
