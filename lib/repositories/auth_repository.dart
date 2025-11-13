import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/services/index.dart';

@Injectable(scope: 'auth')
class AuthRepository {
  final HttpClient _httpClient;

  AuthRepository(this._httpClient);

  Stream<AuthStatus> get authenticationStatus =>
      _httpClient.authenticationStatus;

  Future<void> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return _httpClient.setToken('token');
  }

  Future<void> signOut() {
    return _httpClient.clearToken();
  }
}
