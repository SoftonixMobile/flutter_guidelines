// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../blocs/index.dart' as _i9;
import '../../screens/auth/auth_repository.dart' as _i6;
import '../../screens/auth/bloc/auth_bloc.dart' as _i12;
import '../../screens/home/messages/chats/bloc/chats_bloc.dart' as _i13;
import '../../screens/home/messages/chats/chats_repository.dart' as _i7;
import '../../screens/home/messages/notes/notes_bloc.dart' as _i10;
import '../../screens/home/messages/notes/notes_repository.dart' as _i4;
import '../../screens/home/messages/posts/posts_bloc.dart' as _i11;
import '../../screens/home/messages/posts/posts_repository.dart' as _i5;
import '../../screens/login/login_form_bloc.dart' as _i8;
import '../http/http_client.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  _i1.GetIt init(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i3.HttpClient>(() => _i3.HttpClient());
    gh.factory<_i4.NotesRepository>(
        () => _i4.NotesRepository(get<_i3.HttpClient>()));
    gh.factory<_i5.PostsRepository>(
        () => _i5.PostsRepository(get<_i3.HttpClient>()));
    gh.singleton<_i6.AuthRepository>(
        _i6.AuthRepository(httpClient: get<_i3.HttpClient>()));
    gh.factory<_i7.ChatsRepository>(
        () => _i7.ChatsRepository(get<_i3.HttpClient>()));
    gh.factory<_i8.LoginFormBloc>(() => _i8.LoginFormBloc(
        authBloc: get<_i9.AuthBloc>(), repository: get<_i6.AuthRepository>()));
    gh.factory<_i10.NotesBloc>(
        () => _i10.NotesBloc(get<_i4.NotesRepository>()));
    gh.factory<_i11.PostsBloc>(
        () => _i11.PostsBloc(get<_i5.PostsRepository>()));
    gh.singleton<_i12.AuthBloc>(
        _i12.AuthBloc(repository: get<_i6.AuthRepository>()));
    gh.factory<_i13.ChatsBloc>(
        () => _i13.ChatsBloc(repository: get<_i7.ChatsRepository>()));
    return this;
  }
}
