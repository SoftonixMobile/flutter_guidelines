import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

class SecureTokenStorage extends TokenStorage<String> {
  static final String _tokenKey =
      '${dotenv.get('APP_PROJECT_PREFIX')}Auth_Data';

  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> read() {
    return _storage.read(key: _tokenKey);
  }

  @override
  Future<void> write(String token) {
    return _storage.write(key: _tokenKey, value: token);
  }

  @override
  Future<void> delete() {
    return _storage.delete(key: _tokenKey);
  }
}
