import 'dart:convert';

import 'package:data_provider/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

import 'package:flutter_guidelines/core/index.dart';

class SecureTokenStorage extends TokenStorage<AuthResponse> {
  static const _tokenKey = AppKeys.tokenKey;

  final Logger _logger;
  final _storage = const FlutterSecureStorage();

  SecureTokenStorage(this._logger);

  @override
  Future<AuthResponse?> read() async {
    try {
      final value = await _storage.read(key: _tokenKey);

      return value != null ? AuthResponse.fromJson(jsonDecode(value) as Map<String, dynamic>) : null;
    } catch (e, stackTrace) {
      _logger.logError(e, stackTrace);
    }

    return null;
  }

  @override
  Future<void> write(AuthResponse token) {
    return _storage.write(key: _tokenKey, value: jsonEncode(token.toJson()));
  }

  @override
  Future<void> delete() {
    return _storage.delete(key: _tokenKey);
  }
}
