import 'package:data_provider/data_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(scope: 'auth')
class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Stream<AuthStatus> get authenticationStatus =>
      _authService.authenticationStatus;

  Future<void> signIn(String userName, String password) async {
    return _authService.signIn(userName, password);
  }

  Future<void> signOut() {
    return _authService.signOut();
  }
}
