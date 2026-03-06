import 'package:flutter_guidelines/core/exceptions/app_exception.dart';

enum RemoteExceptionType {
  noConnection,
  timeout,
  badRequest,
  unauthorized,
  notFound,
  clientError,
  serverError,
  unknown,
}

class RemoteException extends AppException {
  final RemoteExceptionType type;
  final int? statusCode;
  final Object? error;

  const RemoteException({
    super.message,
    required this.type,
    this.statusCode,
    this.error,
  });

  @override
  String toString() {
    return 'RemoteException(${type.name}, $statusCode): $message';
  }
}
