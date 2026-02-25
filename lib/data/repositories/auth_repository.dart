import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

@LazySingleton(scope: 'auth')
class AuthRepository {
  final AuthSession _authSession;
  final AuthService _authService;

  AuthRepository(
    this._authSession,
    this._authService,
  );

  Stream<AuthStatus> get authenticationStatus =>
      _authSession.authenticationStatus;

  Future<void> signIn(String userName, String password) async {
    final authResponse = await _authService.signIn(userName, password);

    return _authSession.setToken(authResponse);
  }

  Future<void> signOut() async {
    await _authService.signOut();

    return _authSession.clearToken();
  }
}
