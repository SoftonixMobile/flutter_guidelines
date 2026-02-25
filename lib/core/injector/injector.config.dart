// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_guidelines/data/repositories/auth_repository.dart'
    as _i776;
import 'package:flutter_guidelines/data/repositories/chats_repository.dart'
    as _i148;
import 'package:flutter_guidelines/data/repositories/posts_repository.dart'
    as _i1049;
import 'package:flutter_guidelines/data/repositories/user_repository.dart'
    as _i365;
import 'package:flutter_guidelines/data/services/index.dart' as _i349;
import 'package:flutter_guidelines/domain/auth/auth_manager.dart' as _i192;
import 'package:flutter_guidelines/domain/auth/auth_session.dart' as _i630;
import 'package:flutter_guidelines/domain/models/index.dart' as _i595;
import 'package:flutter_guidelines/domain/repositories/index.dart' as _i64;
import 'package:flutter_guidelines/presentation/blocs/auth/auth_bloc.dart'
    as _i883;
import 'package:flutter_guidelines/presentation/blocs/user/user_bloc.dart'
    as _i492;
import 'package:flutter_guidelines/presentation/screens/auth/login/login_form_bloc.dart'
    as _i175;
import 'package:flutter_guidelines/presentation/screens/main/drawer/drawer_bloc.dart'
    as _i1061;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/chats/bloc/chats_bloc.dart'
    as _i440;
import 'package:flutter_guidelines/presentation/screens/main/messages/tabs/posts/pages/post_modal_bloc.dart'
    as _i387;
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
        gh.factory<_i192.AuthManager>(
          () => _i192.AuthManager(gh<_i630.AuthSession>()),
        );
        gh.lazySingleton<_i365.UserRepository>(
          () => _i365.UserRepository(gh<_i349.UserService>()),
        );
        gh.lazySingleton<_i776.AuthRepository>(
          () => _i776.AuthRepository(
            gh<_i349.AuthService>(),
            gh<_i349.AuthManager>(),
          ),
        );
        gh.factory<_i175.LoginFormBloc>(
          () => _i175.LoginFormBloc(gh<_i64.AuthRepository>()),
        );
        gh.factory<_i883.AuthBloc>(
          () => _i883.AuthBloc(
            gh<_i64.AuthRepository>(),
            gh<_i64.UserRepository>(),
          ),
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
    await _i349.DataProviderPackageModule().init(gh);
    gh.lazySingleton<_i148.ChatsRepository>(
      () => _i148.ChatsRepository(gh<_i349.ChatsService>()),
    );
    gh.lazySingleton<_i1049.PostsRepository>(
      () => _i1049.PostsRepository(gh<_i349.PostsService>()),
      dispose: (i) => i.close(),
    );
    gh.factory<_i440.ChatsBloc>(
      () => _i440.ChatsBloc(gh<_i64.ChatsRepository>()),
    );
    gh.singleton<_i492.UserBloc>(
      () => _i492.UserBloc(gh<_i595.UserData>(), gh<_i64.UserRepository>()),
    );
    gh.factoryParam<_i387.PostModalBloc, _i595.Post?, dynamic>(
      (initial, _) => _i387.PostModalBloc(initial, gh<_i64.PostsRepository>()),
    );
    gh.factory<_i1061.DrawerBloc>(
      () => _i1061.DrawerBloc(gh<_i64.PostsRepository>()),
    );
    gh.factory<_i521.PostsBloc>(
      () => _i521.PostsBloc(gh<_i64.PostsRepository>()),
    );
    return this;
  }
}
