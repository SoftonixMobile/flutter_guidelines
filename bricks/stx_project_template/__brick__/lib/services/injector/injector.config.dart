// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

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
import 'package:{{project_name}}/screens/auth/login/login_form_bloc.dart'
    as _i70;
import 'package:{{project_name}}/screens/main/messages/chats/bloc/chats_bloc.dart'
    as _i219;
import 'package:{{project_name}}/screens/main/messages/posts/posts_bloc.dart'
    as _i624;
import 'package:{{project_name}}/services/http/http_client.dart' as _i257;
import 'package:{{project_name}}/services/index.dart' as _i647;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i66.ChatsRepository>(() => _i66.ChatsRepository());
    gh.factory<_i879.PostsRepository>(
      () => _i879.PostsRepository(gh<_i647.HttpClient>()),
    );
    gh.lazySingleton<_i219.ChatsBloc>(
      () => _i219.ChatsBloc(gh<_i293.ChatsRepository>()),
    );
    gh.lazySingleton<_i624.PostsBloc>(
      () => _i624.PostsBloc(gh<_i293.PostsRepository>()),
    );
    return this;
  }

  // initializes the registration of auth-scope dependencies inside of GetIt
  _i174.GetIt initAuthScope({_i174.ScopeDisposeFunc? dispose}) {
    return _i526.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i526.GetItHelper gh) {
        gh.factory<_i557.UserRepository>(() => _i557.UserRepository());
        gh.singleton<_i257.HttpClient>(
          () => _i257.HttpClient(logger: gh<_i647.Logger>()),
        );
        gh.factory<_i567.AuthRepository>(
          () => _i567.AuthRepository(gh<_i647.HttpClient>()),
        );
        gh.factory<_i70.LoginFormBloc>(
          () => _i70.LoginFormBloc(gh<_i293.AuthRepository>()),
        );
        gh.singleton<_i495.AuthBloc>(
          () => _i495.AuthBloc(
            gh<_i293.AuthRepository>(),
            gh<_i293.UserRepository>(),
          ),
        );
      },
    );
  }
}
