class const AppException({final String? message}) implements Exception {
  @override
  String toString() => 'AppException: $message';
}
