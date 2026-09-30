import 'package:data_provider/models.dart';
import 'package:data_provider/network.dart';
import 'package:injectable/injectable.dart';

@injectable
class AuthService(final ApiClient _client) {
  this {
    _client.registerType(TokenResponse.fromJson);
  }

  Future<TokenResponse> signIn(String userName, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return const TokenResponse(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
    );
  }

  Future<void> signOut() {
    return Future.delayed(const Duration(seconds: 1));
  }
}
