part of 'session_bloc.dart';

@freezed
class SessionEvent with _$SessionEvent {
  const factory subscribe() = _Subscribe;
  const factory signOut() = _SignOut;
}
