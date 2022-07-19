part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.appStarted() = _AppStarted;
  const factory AuthEvent.authDataChanged(String authData) = _AuthDataChanged;
  const factory AuthEvent.logout() = _Logout;
}
