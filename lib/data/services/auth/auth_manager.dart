import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'base/auth_session.dart';

@Injectable(scope: 'auth')
class AuthManager {
  final AuthSession _authSession;

  AuthManager(this._authSession);

  Stream<AuthStatus> get authStatusStream => _authSession.authenticationStatus;

  Future<void> setToken(String authResponse) {
    return _authSession.setToken(authResponse);
  }

  Future<void> clearToken() {
    return _authSession.clearToken();
  }
}
