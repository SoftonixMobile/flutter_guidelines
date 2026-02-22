import 'package:injectable/injectable.dart';

import 'package:data_provider/network.dart';

@injectable
class AuthService {
  final NetworkBaseClient _networkClient;

  AuthService(this._networkClient);

  Future<String> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return 'token';
  }

  Future<void> signOut() {
    return Future.delayed(const Duration(seconds: 1));
  }
}
