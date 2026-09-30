enum ApiExceptionType() {
  noConnection,
  timeout,
  cancelled,
  badCertificate,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  tooManyRequests,
  clientError,
  serviceUnavailable,
  serverError,
  unknown,
}

class const ApiException({
  required final ApiExceptionType type,
  final String? message,
  final int? statusCode,
  final Object? error,
}) implements Exception {
  @override
  String toString() {
    return 'ApiException(${type.name}, $statusCode): $message';
  }
}
