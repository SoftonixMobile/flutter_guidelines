part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  unauthenticated,
  authenticated,
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    String? authData,
  }) = _AuthState;

  factory AuthState.authenticated(String authData) => AuthState(
        status: AuthStatus.authenticated,
        authData: authData,
      );

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthStatus.unauthenticated);
}
