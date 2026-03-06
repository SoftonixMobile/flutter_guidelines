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
import 'package:flutter_guidelines/domain/auth/index.dart' as _i826;
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
import 'package:flutter_guidelines/presentation/screens/main/messages/chats/bloc/chats_bloc.dart'
    as _i73;
import 'package:flutter_guidelines/presentation/screens/main/messages/posts/pages/post_form_bloc.dart'
    as _i233;
import 'package:flutter_guidelines/presentation/screens/main/messages/posts/posts_bloc.dart'
    as _i830;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i492.UserBloc>(
      () => _i492.UserBloc(gh<_i64.UserRepository>()),
    );
    gh.lazySingleton<_i148.ChatsRepository>(
      () => _i148.ChatsRepository(gh<_i349.ChatsService>()),
    );
    gh.lazySingleton<_i1049.PostsRepository>(
      () => _i1049.PostsRepository(gh<_i349.PostsService>()),
      dispose: (i) => i.close(),
    );
    gh.factory<_i73.ChatsBloc>(
      () => _i73.ChatsBloc(gh<_i64.ChatsRepository>()),
    );
    gh.factoryParam<_i233.PostFormBloc, _i595.Post?, dynamic>(
      (initial, _) => _i233.PostFormBloc(initial, gh<_i64.PostsRepository>()),
    );
    gh.factory<_i1061.DrawerBloc>(
      () => _i1061.DrawerBloc(gh<_i64.PostsRepository>()),
    );
    gh.factory<_i830.PostsBloc>(
      () => _i830.PostsBloc(gh<_i64.PostsRepository>()),
    );
    return this;
  }

  // initializes the registration of auth-scope dependencies inside of GetIt
  _i174.GetIt initAuthScope({_i174.ScopeDisposeFunc? dispose}) {
    return _i526.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i526.GetItHelper gh) {
        gh.lazySingleton<_i776.AuthRepository>(
          () => _i776.AuthRepository(
            gh<_i826.AuthSession>(),
            gh<_i349.AuthService>(),
          ),
        );
        gh.lazySingleton<_i365.UserRepository>(
          () => _i365.UserRepository(
            gh<_i595.UserData>(),
            gh<_i349.UserService>(),
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
}
