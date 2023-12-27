// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_guidelines/blocs/auth/auth_bloc.dart' as _i6;
import 'package:flutter_guidelines/blocs/index.dart' as _i9;
import 'package:flutter_guidelines/repositories/auth_repository.dart' as _i5;
import 'package:flutter_guidelines/repositories/chats_repository.dart' as _i10;
import 'package:flutter_guidelines/repositories/index.dart' as _i7;
import 'package:flutter_guidelines/repositories/posts_repository.dart' as _i11;
import 'package:flutter_guidelines/repositories/user_repository.dart' as _i4;
import 'package:flutter_guidelines/screens/home/messages/chats/bloc/chats_bloc.dart'
    as _i12;
import 'package:flutter_guidelines/screens/home/messages/posts/posts_bloc.dart'
    as _i13;
import 'package:flutter_guidelines/screens/login/login_form_bloc.dart' as _i8;
import 'package:flutter_guidelines/services/http/http_client.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of auth-scope dependencies inside of GetIt
  _i1.GetIt initAuthScope({_i1.ScopeDisposeFunc? dispose}) {
    return _i2.GetItHelper(this).initScope(
      'auth',
      dispose: dispose,
      init: (_i2.GetItHelper gh) {
        gh.singleton<_i3.HttpClient>(_i3.HttpClient());
        gh.factory<_i4.UserRepository>(
            () => _i4.UserRepository(gh<_i3.HttpClient>()));
        gh.factory<_i5.AuthRepository>(
            () => _i5.AuthRepository(gh<_i3.HttpClient>()));
        gh.singleton<_i6.AuthBloc>(_i6.AuthBloc(
          authRepository: gh<_i7.AuthRepository>(),
          userRepository: gh<_i7.UserRepository>(),
        ));
        gh.factory<_i8.LoginFormBloc>(() => _i8.LoginFormBloc(
              authBloc: gh<_i9.AuthBloc>(),
              repository: gh<_i5.AuthRepository>(),
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
    gh.lazySingleton<_i12.ChatsBloc>(
        () => _i12.ChatsBloc(repository: gh<_i7.ChatsRepository>()));
    gh.lazySingleton<_i13.PostsBloc>(
        () => _i13.PostsBloc(gh<_i7.PostsRepository>()));
    return this;
  }
}
