part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthenticationStatus.initial) AuthenticationStatus status,
    @Default(UserProfile()) UserProfile userProfile,
  }) = _AuthState;

  factory AuthState.authenticated(
    UserProfile userProfile,
  ) =>
      AuthState(
        status: AuthenticationStatus.authenticated,
        userProfile: userProfile,
      );

  factory AuthState.unauthenticated() =>
      const AuthState(status: AuthenticationStatus.unauthenticated);
}
