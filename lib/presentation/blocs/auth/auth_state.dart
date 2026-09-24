part of 'auth_bloc.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory({
    @Default(AuthStatus.initial) AuthStatus status,
  }) = _AuthState;

  factory authenticated() => const AuthState(
    status: .authenticated,
  );

  factory unauthenticated() => const AuthState(
    status: .unauthenticated,
  );
}
