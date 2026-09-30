import 'dart:io';

import 'package:dio/dio.dart';

import 'api_exception.dart';

abstract final class ApiExceptionMapper() {
  static ApiException fromDioException(DioException e) {
    return switch (e.type) {
      .badResponse => _fromResponse(e),
      _ => ApiException(
        type: _typeOf(e),
        message: e.message,
        error: e.error,
      ),
    };
  }

  static ApiExceptionType _typeOf(DioException e) {
    return switch (e.type) {
      .connectionError => .noConnection,
      .unknown when e.error is SocketException => .noConnection,
      .connectionTimeout || .receiveTimeout || .sendTimeout => .timeout,
      .cancel => .cancelled,
      .badCertificate => .badCertificate,
      _ => .unknown,
    };
  }

  static ApiException _fromResponse(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode;
    final data = response?.data;

    final message =
        (data is Map<String, dynamic>
            ? data['message'] as String? ?? data['error'] as String?
            : null) ??
        e.message;

    return ApiException(
      type: switch (statusCode) {
        null => .unknown,
        400 => .badRequest,
        401 => .unauthorized,
        403 => .forbidden,
        404 => .notFound,
        429 => .tooManyRequests,
        >= 400 && < 500 => .clientError,
        503 => .serviceUnavailable,
        >= 500 => .serverError,
        _ => .unknown,
      },
      statusCode: statusCode,
      message: message,
      error: e.error,
    );
  }
}
