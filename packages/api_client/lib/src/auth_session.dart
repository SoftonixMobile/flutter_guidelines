import 'models/index.dart';

abstract class AuthSession() {
  AuthStatus get status;

  Stream<AuthStatus> get onStatusChanged;

  Future<void> start(AuthToken token);

  Future<void> clear();
}
