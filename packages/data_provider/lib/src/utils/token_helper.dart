import 'dart:convert';

import '../models/auth/models.dart';

abstract final class TokenHelper() {
  /// Treats the token as expired 30 seconds early, so it doesn't expire
  /// while the request is in flight.
  static const _expirationLeeway = Duration(seconds: 30);

  static bool isExpired(TokenResponse token) {
    final expiresAt = _readExpiration(token.accessToken);
    if (expiresAt == null) return false;

    return DateTime.now().add(_expirationLeeway).isAfter(expiresAt);
  }

  /// Reads the `exp` claim of a JWT. Returns `null` when [accessToken] isn't
  /// a JWT or has no `exp` claim.
  static DateTime? _readExpiration(String accessToken) {
    final parts = accessToken.split('.');
    if (parts.length != 3) return null;

    try {
      final payload = utf8.decode(
        base64Url.decode(base64Url.normalize(parts[1])),
      );
      final exp = (jsonDecode(payload) as Map<String, dynamic>)['exp'];
      if (exp is! num) return null;

      return DateTime.fromMillisecondsSinceEpoch(exp.toInt() * 1000);
    } catch (_) {
      return null;
    }
  }
}
