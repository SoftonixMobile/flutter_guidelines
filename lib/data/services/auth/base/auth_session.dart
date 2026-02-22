import 'package:flutter_guidelines/domain/models/index.dart';

abstract class AuthSession {
  Stream<AuthStatus> get authenticationStatus;

  Future<void> setToken(String token);
  Future<void> clearToken();
}
