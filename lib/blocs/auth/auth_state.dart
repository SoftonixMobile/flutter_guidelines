part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    @Default(UserProfile()) UserProfile userProfile,
  }) = _AuthState;

  factory AuthState.authenticated(UserProfile userProfile) => AuthState(
    status: AuthStatus.authenticated,
    userProfile: userProfile,
  );

  factory AuthState.unauthenticated() => const AuthState(
    status: AuthStatus.unauthenticated,
  );
}
