import 'package:injectable/injectable.dart';

import 'package:flutter_guidelines/services/http/http_client.dart';

@injectable
class AuthRepository {
  AuthRepository({required this.httpClient});

  final HttpClient httpClient;

  Future<String> login(String username, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    return 'login success';
  }

  Future<dynamic> getUserById(int id) async {
    final response = await httpClient.get('/users/$id');

    return response.data;
  }
}
