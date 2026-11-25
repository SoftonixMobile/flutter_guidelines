part of 'session_bloc.dart';

@freezed
sealed class SessionState with _$SessionState {
  const factory({
    @Default(AuthStatus.initial) AuthStatus authStatus,
  }) = _SessionState;

  factory authenticated() => const SessionState(
    authStatus: .authenticated,
  );

  factory unauthenticated() => const SessionState(
    authStatus: .unauthenticated,
  );
}
