import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter_guidelines/domain/exceptions/index.dart';

abstract final class RemoteExceptionMapper {
  static RemoteException fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionError || DioExceptionType.unknown
          when e.error is SocketException =>
        RemoteException(
          type: RemoteExceptionType.noConnection,
          message: e.message,
          error: e.error,
        ),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => RemoteException(
        type: RemoteExceptionType.timeout,
        message: e.message,
        error: e.error,
      ),
      DioExceptionType.badResponse => _fromResponse(e),
      _ => RemoteException(
        type: RemoteExceptionType.unknown,
        message: e.message,
        error: e.error,
      ),
    };
  }

  static RemoteException _fromResponse(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    final message =
        (data is Map<String, dynamic>
            ? data['message'] as String? ?? data['error'] as String?
            : null) ??
        e.message;

    final type = switch (statusCode) {
      null => RemoteExceptionType.unknown,
      400 => RemoteExceptionType.badRequest,
      401 => RemoteExceptionType.unauthorized,
      404 => RemoteExceptionType.notFound,
      >= 400 && < 500 => RemoteExceptionType.clientError,
      >= 500 => RemoteExceptionType.serverError,
      _ => RemoteExceptionType.unknown,
    };

    return RemoteException(
      type: type,
      statusCode: statusCode,
      message: message,
      error: e.error,
    );
  }
}
