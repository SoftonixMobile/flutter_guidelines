import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/models/index.dart';
import 'package:{{project_name}}/repositories/index.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

@Singleton(scope: 'auth')
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late final StreamSubscription<AuthStatus> _statusSubscription;

  AuthBloc(
    this._authRepository,
    this._userRepository,
  ) : super(const AuthState()) {
    _statusSubscription = _authRepository.authenticationStatus.listen((status) {
      add(AuthEvent.authenticationStatusChanged(status));
    });

    on<_AuthenticationStatusChanged>(_authenticationStatusChanged);
    on<_SignOut>(_signOut);
  }

  FutureOr<void> _authenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.status == .authenticated) {
      try {
        final userProfile = await _userRepository.getUserProfile();

        emit(AuthState.authenticated(userProfile));
      } catch (e, stackTrace) {
        addError(e, stackTrace);

        emit(AuthState.unauthenticated());
      }
    } else {
      emit(
        state.copyWith(
          status: event.status,
          userProfile: const UserProfile(),
        ),
      );
    }
  }

  FutureOr<void> _signOut(_SignOut event, Emitter<AuthState> emit) {
    return _authRepository.signOut();
  }

  @override
  Future<void> close() async {
    await _statusSubscription.cancel();
    return super.close();
  }
}
