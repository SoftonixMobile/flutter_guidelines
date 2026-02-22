part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
  }) = _AuthState;

  factory AuthState.authenticated() => const AuthState(
    status: .authenticated,
  );

  factory AuthState.unauthenticated() => const AuthState(
    status: .unauthenticated,
  );
}
