import 'package:fresh_dio/fresh_dio.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/services/http/http_client.dart';
import 'models/models.dart';

@singleton
class AuthRepository {
  final HttpClient httpClient;

  AuthRepository({required this.httpClient});

  Stream<AuthenticationStatus> get authenticationStatus =>
      httpClient.authenticationStatus;

  Future<void> signIn(String userName, String password) {
    return httpClient.authenticate(userName, password);
  }

  Future<UserProfile> getUserProfile() async {
    return UserProfile.fromJson({'userName': 'test'});
  }

  Future<void> signOut() {
    return httpClient.unauthenticate();
  }
}
