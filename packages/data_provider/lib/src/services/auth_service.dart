import 'package:injectable/injectable.dart';

import 'package:data_provider/network.dart';

@injectable
class AuthService {
  final NetworkBaseClient _networkClient;

  AuthService(this._networkClient);

  Stream<AuthStatus> get authenticationStatus =>
      _networkClient.authStatusStream;

  Future<void> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return _networkClient.setToken('token');
  }

  Future<void> signOut() {
    return _networkClient.clearToken();
  }
}
