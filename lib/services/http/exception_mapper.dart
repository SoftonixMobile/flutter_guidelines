import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter_guidelines/core/index.dart';

abstract final class AppExceptionMapper {
  static NetworkException fromDioException(DioException e) {
    return switch (e.type) {
      DioExceptionType.connectionError || DioExceptionType.unknown
          when e.error is SocketException =>
        NetworkException(
          type: NetworkExceptionType.noConnection,
          message: e.message,
          error: e.error,
        ),
      DioExceptionType.connectionTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.sendTimeout => NetworkException(
        type: NetworkExceptionType.timeout,
        message: e.message,
        error: e.error,
      ),
      DioExceptionType.badResponse => _fromResponse(e),
      _ => NetworkException(
        type: NetworkExceptionType.unknown,
        message: e.message,
        error: e.error,
      ),
    };
  }

  static NetworkException _fromResponse(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    final message =
        (data is Map<String, dynamic>
            ? data['message'] as String? ?? data['error'] as String?
            : null) ??
        e.message;

    final type = switch (statusCode) {
      null => NetworkExceptionType.unknown,
      400 => NetworkExceptionType.badRequest,
      401 => NetworkExceptionType.unauthorized,
      404 => NetworkExceptionType.notFound,
      >= 400 && < 500 => NetworkExceptionType.clientError,
      >= 500 => NetworkExceptionType.serverError,
      _ => NetworkExceptionType.unknown,
    };

    return NetworkException(
      type: type,
      statusCode: statusCode,
      message: message,
      error: e.error,
    );
  }
}
