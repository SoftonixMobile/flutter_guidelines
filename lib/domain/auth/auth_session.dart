import 'package:flutter_guidelines/domain/models/index.dart';

abstract class AuthSession {
  Stream<AuthStatus> get authenticationStatus;

  Future<void> setToken(AuthResponse token);

  Future<void> clearToken();
}
