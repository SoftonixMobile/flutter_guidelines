part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory authenticationStatusChanged(
    AuthStatus status,
  ) = _AuthenticationStatusChanged;
  const factory signOut() = _SignOut;
}
