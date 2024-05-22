// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:{{project_name}}/blocs/auth/auth_bloc.dart' as _i6;
import 'package:{{project_name}}/blocs/index.dart' as _i9;
import 'package:{{project_name}}/repositories/auth_repository.dart' as _i4;
import 'package:{{project_name}}/repositories/chats_repository.dart' as _i10;
import 'package:{{project_name}}/repositories/index.dart' as _i7;
import 'package:{{project_name}}/repositories/posts_repository.dart' as _i11;
import 'package:{{project_name}}/repositories/user_repository.dart' as _i5;
import 'package:{{project_name}}/screens/home/messages/chats/bloc/chats_bloc.dart'
    as _i13;
import 'package:{{project_name}}/screens/home/messages/posts/posts_bloc.dart'
    as _i12;
import 'package:{{project_name}}/screens/login/login_form_bloc.dart' as _i8;
import 'package:{{project_name}}/services/http/http_client.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of auth-scope dependencies inside of GetIt
  _i1.GetIt initAuthScope({_i1.ScopeDisposeFunc? dispose}) {
    return _i2.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i2.GetItHelper gh) {
        gh.singleton<_i3.HttpClient>(() => _i3.HttpClient());
        gh.factory<_i4.AuthRepository>(
            () => _i4.AuthRepository(gh<_i3.HttpClient>()));
        gh.factory<_i5.UserRepository>(
            () => _i5.UserRepository(gh<_i3.HttpClient>()));
        gh.singleton<_i6.AuthBloc>(() => _i6.AuthBloc(
              authRepository: gh<_i7.AuthRepository>(),
              userRepository: gh<_i7.UserRepository>(),
            ));
        gh.factory<_i8.LoginFormBloc>(() => _i8.LoginFormBloc(
              authBloc: gh<_i9.AuthBloc>(),
              repository: gh<_i4.AuthRepository>(),
            ));
      },
    );
  }

// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i10.ChatsRepository>(
        () => _i10.ChatsRepository(gh<_i3.HttpClient>()));
    gh.factory<_i11.PostsRepository>(
        () => _i11.PostsRepository(gh<_i3.HttpClient>()));
    gh.lazySingleton<_i12.PostsBloc>(
        () => _i12.PostsBloc(gh<_i7.PostsRepository>()));
    gh.lazySingleton<_i13.ChatsBloc>(
        () => _i13.ChatsBloc(repository: gh<_i7.ChatsRepository>()));
    return this;
  }
}
