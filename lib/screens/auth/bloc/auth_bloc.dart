import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final String _authDataKey =
      dotenv.get('APP_PROJECT_PREFIX') + 'Auth_Data';

  AuthBloc({
    required this.repository,
  }) : super(const AuthState()) {
    on<_AppStarted>(_appStarted);
    on<_AuthDataChanged>(_authDataChanged);
    on<_Logout>(_logout);
  }

  final AuthRepository repository;

  void appStarted() => add(const AuthEvent.appStarted());

  void authDataChanged(String authData) =>
      add(AuthEvent.authDataChanged(authData));

  void logout() => add(const AuthEvent.logout());

  FutureOr<void> _appStarted(_AppStarted event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      if (prefs.containsKey(_authDataKey)) {
        final authData = prefs.getString(_authDataKey) ?? '';

        emit(AuthState.authenticated(authData));
      } else {
        emit(AuthState.unauthenticated());
      }
    } catch (_) {
      emit(AuthState.unauthenticated());
    }
  }

  FutureOr<void> _authDataChanged(
      _AuthDataChanged event, Emitter<AuthState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      prefs.setString(_authDataKey, event.authData);

      emit(AuthState.authenticated(event.authData));
    } on Exception catch (_) {
      emit(AuthState.unauthenticated());
    }
  }

  FutureOr<void> _logout(_Logout event, Emitter<AuthState> emit) async {
    (await SharedPreferences.getInstance()).clear();

    emit(AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
