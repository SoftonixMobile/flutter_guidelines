import 'dart:io';

import 'package:data_provider/network.dart';
import 'package:data_provider/src/client/exceptions/api_exception_mapper.dart';
import 'package:dio/dio.dart' as dio;
import 'package:test/test.dart';

final _request = dio.RequestOptions(path: '/test');

dio.DioException _badResponse(int? statusCode, {Object? data}) {
  return dio.DioException.badResponse(
    statusCode: statusCode ?? 0,
    requestOptions: _request,
    response: dio.Response(
      requestOptions: _request,
      statusCode: statusCode,
      data: data,
    ),
  );
}

void main() {
  group('ApiExceptionMapper', () {
    test('maps a connection error to noConnection', () {
      final exception = ApiExceptionMapper.fromDioException(
        dio.DioException.connectionError(
          requestOptions: _request,
          reason: 'offline',
        ),
      );

      expect(exception.type, ApiExceptionType.noConnection);
    });

    test('maps an unknown SocketException to noConnection', () {
      final error = const SocketException('offline');
      final exception = ApiExceptionMapper.fromDioException(
        dio.DioException(requestOptions: _request, error: error),
      );

      expect(exception.type, ApiExceptionType.noConnection);
      expect(exception.error, error);
    });

    test('maps timeouts to timeout', () {
      for (final type in [
        dio.DioExceptionType.connectionTimeout,
        dio.DioExceptionType.receiveTimeout,
        dio.DioExceptionType.sendTimeout,
      ]) {
        final exception = ApiExceptionMapper.fromDioException(
          dio.DioException(requestOptions: _request, type: type),
        );

        expect(exception.type, ApiExceptionType.timeout, reason: '$type');
      }
    });

    test('maps status codes to types', () {
      const expected = {
        400: ApiExceptionType.badRequest,
        401: ApiExceptionType.unauthorized,
        403: ApiExceptionType.forbidden,
        404: ApiExceptionType.notFound,
        429: ApiExceptionType.tooManyRequests,
        409: ApiExceptionType.clientError,
        500: ApiExceptionType.serverError,
        502: ApiExceptionType.serverError,
        503: ApiExceptionType.serviceUnavailable,
        302: ApiExceptionType.unknown,
      };

      for (final MapEntry(key: statusCode, value: type) in expected.entries) {
        final exception = ApiExceptionMapper.fromDioException(
          _badResponse(statusCode),
        );

        expect(exception.type, type, reason: '$statusCode');
        expect(exception.statusCode, statusCode);
      }
    });

    test('maps a bad response without a status code to unknown', () {
      final exception = ApiExceptionMapper.fromDioException(_badResponse(null));

      expect(exception.type, ApiExceptionType.unknown);
      expect(exception.statusCode, isNull);
    });

    test('reads the message from the response body', () {
      expect(
        ApiExceptionMapper.fromDioException(
          _badResponse(400, data: {'message': 'Invalid email'}),
        ).message,
        'Invalid email',
      );
      expect(
        ApiExceptionMapper.fromDioException(
          _badResponse(400, data: {'error': 'Invalid email'}),
        ).message,
        'Invalid email',
      );
    });

    test('falls back to the DioException message', () {
      final dioException = _badResponse(400, data: 'plain text');

      expect(
        ApiExceptionMapper.fromDioException(dioException).message,
        dioException.message,
      );
    });

    test('maps a cancelled request to cancelled', () {
      final exception = ApiExceptionMapper.fromDioException(
        dio.DioException.requestCancelled(
          requestOptions: _request,
          reason: 'cancelled',
        ),
      );

      expect(exception.type, ApiExceptionType.cancelled);
    });

    test('maps a bad certificate to badCertificate', () {
      final exception = ApiExceptionMapper.fromDioException(
        dio.DioException.badCertificate(requestOptions: _request),
      );

      expect(exception.type, ApiExceptionType.badCertificate);
    });

    test('maps an unknown error to unknown', () {
      final exception = ApiExceptionMapper.fromDioException(
        dio.DioException(requestOptions: _request, error: StateError('boom')),
      );

      expect(exception.type, ApiExceptionType.unknown);
    });
  });
}
