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

class const NetworkException({
  super.message,
  required final NetworkExceptionType type,
  final int? statusCode,
  final Object? error,
}) extends AppException {
  @override
  String toString() {
    return 'NetworkException(${type.name}, $statusCode): $message';
  }
}
