import 'dart:io';

import 'package:dio/dio.dart';

import 'package:{{project_name}}/core/index.dart';

abstract final class AppExceptionMapper() {
  static NetworkException fromDioException(DioException e) {
    return switch (e.type) {
      .connectionError ||
      .unknown when e.error is SocketException => NetworkException(
        type: .noConnection,
        message: e.message,
        error: e.error,
      ),
      .connectionTimeout || .receiveTimeout || .sendTimeout => NetworkException(
        type: .timeout,
        message: e.message,
        error: e.error,
      ),
      .badResponse => _fromResponse(e),
      _ => NetworkException(
        type: .unknown,
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

    return NetworkException(
      type: switch (statusCode) {
        null => .unknown,
        400 => .badRequest,
        401 => .unauthorized,
        404 => .notFound,
        >= 400 && < 500 => .clientError,
        >= 500 => .serverError,
        _ => .unknown,
      },
      statusCode: statusCode,
      message: message,
      error: e.error,
    );
  }
}
