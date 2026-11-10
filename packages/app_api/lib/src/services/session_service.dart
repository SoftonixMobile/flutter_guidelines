import 'package:api_client/api_client.dart';
import 'package:app_api/models.dart';
import 'package:injectable/injectable.dart';

@injectable
class SessionService(final AuthSession _session) {
  AuthStatus get authStatus => _session.status;

  Stream<AuthStatus> get onAuthStatusChanged => _session.onStatusChanged;

  bool get isAuthenticated => authStatus == .authenticated;

  Future<void> startSession(TokenResponse token) => _session.start(
    AuthToken(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
    ),
  );

  Future<void> clearSession() => _session.clear();
}
