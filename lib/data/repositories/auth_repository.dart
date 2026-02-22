import 'package:data_provider/services.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

@LazySingleton(scope: 'auth')
class AuthRepository {
  final AuthService _authService;
  final AuthManager _authManager;

  AuthRepository(this._authService, this._authManager);

  Stream<AuthStatus> get authenticationStatus => _authManager.authStatusStream;

  Future<void> signIn(String userName, String password) async {
    final token = await _authService.signIn(userName, password);

    return _authManager.setToken(token);
  }

  Future<void> signOut() async {
    await _authService.signOut();

    return _authManager.clearToken();
  }
}
