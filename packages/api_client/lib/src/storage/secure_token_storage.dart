import 'dart:convert';

import 'package:fresh_dio/fresh_dio.dart';
import 'package:storage/storage.dart';

import '../models/auth_token.dart';

class SecureTokenStorage(final Storage _storage)
    implements TokenStorage<AuthToken> {
  static const _tokenKey = 'auth_token';

  @override
  Future<AuthToken?> read() async {
    try {
      final value = await _storage.read(key: _tokenKey);

      return value != null
          ? AuthToken.fromJson(jsonDecode(value) as Map<String, dynamic>)
          : null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> write(AuthToken token) {
    return _storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
  }

  @override
  Future<void> delete() {
    return _storage.delete(key: _tokenKey);
  }
}
