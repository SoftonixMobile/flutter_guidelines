import 'app_exception.dart';

enum NetworkExceptionType {
  noConnection,
  timeout,
  badRequest,
  unauthorized,
  notFound,
  clientError,
  serverError,
  unknown,
}

class NetworkException extends AppException {
  final NetworkExceptionType type;
  final int? statusCode;
  final Object? error;

  const NetworkException({
    super.message,
    required this.type,
    this.statusCode,
    this.error,
  });

  @override
  String toString() {
    return 'NetworkException(${type.name}, $statusCode): $message';
  }
}
