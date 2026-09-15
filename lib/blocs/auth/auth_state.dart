part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory({
    @Default(AuthStatus.initial) AuthStatus status,
    @Default(UserProfile()) UserProfile userProfile,
  }) = _AuthState;

  factory authenticated(UserProfile userProfile) => AuthState(
    status: .authenticated,
    userProfile: userProfile,
  );

  factory unauthenticated() => const AuthState(
    status: .unauthenticated,
  );
}
