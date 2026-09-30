import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class SessionService(final ApiClient _client) {
  Stream<AuthStatus> get onStatusChanged => _client.onSessionStatusChanged;

  Future<void> start(TokenResponse token) => _client.startSession(token);

  Future<void> clear() => _client.clearSession();
}
