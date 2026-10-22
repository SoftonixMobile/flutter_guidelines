part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory subscribe() = _Subscribe;
  const factory signOut() = _SignOut;
}
