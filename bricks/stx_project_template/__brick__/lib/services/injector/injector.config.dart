// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:{{project_name}}/blocs/auth/auth_bloc.dart' as _i495;
import 'package:{{project_name}}/repositories/auth_repository.dart' as _i567;
import 'package:{{project_name}}/repositories/chats_repository.dart' as _i66;
import 'package:{{project_name}}/repositories/index.dart' as _i293;
import 'package:{{project_name}}/repositories/posts_repository.dart' as _i879;
import 'package:{{project_name}}/repositories/user_repository.dart' as _i557;
import 'package:{{project_name}}/screens/home/messages/chats/bloc/chats_bloc.dart'
    as _i607;
import 'package:{{project_name}}/screens/home/messages/posts/posts_bloc.dart'
    as _i748;
import 'package:{{project_name}}/screens/login/login_form_bloc.dart' as _i31;
import 'package:{{project_name}}/services/http/http_client.dart' as _i257;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of auth-scope dependencies inside of GetIt
  _i174.GetIt initAuthScope({_i174.ScopeDisposeFunc? dispose}) {
    return _i526.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i526.GetItHelper gh) {
        gh.singleton<_i257.HttpClient>(() => _i257.HttpClient());
        gh.factory<_i567.AuthRepository>(
          () => _i567.AuthRepository(gh<_i257.HttpClient>()),
        );
        gh.factory<_i557.UserRepository>(
          () => _i557.UserRepository(gh<_i257.HttpClient>()),
        );
        gh.factory<_i31.LoginFormBloc>(
          () => _i31.LoginFormBloc(authRepository: gh<_i567.AuthRepository>()),
        );
        gh.singleton<_i495.AuthBloc>(
          () => _i495.AuthBloc(
            authRepository: gh<_i293.AuthRepository>(),
            userRepository: gh<_i293.UserRepository>(),
          ),
        );
      },
    );
  }

  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i66.ChatsRepository>(
      () => _i66.ChatsRepository(gh<_i257.HttpClient>()),
    );
    gh.factory<_i879.PostsRepository>(
      () => _i879.PostsRepository(gh<_i257.HttpClient>()),
    );
    gh.lazySingleton<_i607.ChatsBloc>(
      () => _i607.ChatsBloc(chatsRepository: gh<_i293.ChatsRepository>()),
    );
    gh.lazySingleton<_i748.PostsBloc>(
      () => _i748.PostsBloc(postsRepository: gh<_i293.PostsRepository>()),
    );
    return this;
  }
}
