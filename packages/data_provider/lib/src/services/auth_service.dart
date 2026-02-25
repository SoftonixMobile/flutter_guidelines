import 'package:injectable/injectable.dart';

import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';

@injectable
class AuthService {
  final ApiClient _client;

  AuthService(this._client) {
    _client.registerType(AuthResponse.fromJson);
  }

  Future<AuthResponse> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return const AuthResponse(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
  }

  Future<void> signOut() {
    return Future.delayed(const Duration(seconds: 1));
  }
}
