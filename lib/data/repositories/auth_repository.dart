import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/domain/models/index.dart';

@LazySingleton(scope: 'app')
class AuthRepository(
  final AuthService _authService,
  final SessionService _sessionService,
) {
  Stream<AuthStatus> get onAuthStatusChanged =>
      _sessionService.onAuthStatusChanged;

  Future<void> signIn(String userName, String password) async {
    final token = await _authService.signIn(userName, password);

    return await _sessionService.startSession(token);
  }

  Future<void> signOut() async {
    await _authService.signOut();

    return await _sessionService.clearSession();
  }
}
