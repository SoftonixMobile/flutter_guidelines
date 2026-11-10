import 'package:api_client/api_client.dart';
import 'package:app_api/models.dart';

abstract final class AuthTokenRefresher() {
  static Future<AuthToken> refresh(AuthToken token, ApiClient client) async {
    await Future.delayed(const Duration(seconds: 1));

    return const TokenResponse(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    ).toAuthToken();
  }
}
