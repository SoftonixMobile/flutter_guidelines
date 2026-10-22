import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class SessionService(final ApiClient _client) {
  AuthStatus get authStatus => _client.authStatus;

  Stream<AuthStatus> get onAuthStatusChanged => _client.onAuthStatusChanged;

  bool get isAuthenticated => authStatus == .authenticated;

  Future<void> startSession(TokenResponse token) => _client.startSession(token);

  Future<void> clearSession() => _client.clearSession();
}
