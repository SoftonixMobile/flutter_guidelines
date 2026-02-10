import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService {
  final NetworkBaseClient _networkClient;

  AuthService(this._networkClient);

  Future<void> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return _networkClient.setToken('token');
  }

  Future<void> signOut() {
    return _networkClient.clearToken();
  }
}
