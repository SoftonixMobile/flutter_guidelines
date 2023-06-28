import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/services/http/http_client.dart';

@Injectable(scope: 'auth')
class AuthRepository {
  final HttpClient httpClient;

  AuthRepository(this.httpClient);

  Stream<AuthenticationStatus> get authenticationStatus =>
      httpClient.authenticationStatus;

  Future<void> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return httpClient.setToken('token');
  }

  Future<void> signOut() {
    return httpClient.clearToken();
  }
}
