// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../blocs/index.dart' as _i6;
import '../../screens/auth/auth_repository.dart' as _i4;
import '../../screens/auth/bloc/auth_bloc.dart' as _i7;
import '../../screens/login/login_form_bloc.dart' as _i5;
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
    gh.factory<_i4.AuthRepository>(
        () => _i4.AuthRepository(httpClient: get<_i3.HttpClient>()));
    gh.factory<_i5.LoginFormBloc>(() => _i5.LoginFormBloc(
        authBloc: get<_i6.AuthBloc>(), repository: get<_i4.AuthRepository>()));
    gh.singleton<_i7.AuthBloc>(
        _i7.AuthBloc(repository: get<_i4.AuthRepository>()));
    return this;
  }
}
