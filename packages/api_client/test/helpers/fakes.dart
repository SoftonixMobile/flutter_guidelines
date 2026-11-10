import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:storage/storage.dart';

class InMemoryStorage() implements Storage {
  final values = <String, String>{};

  @override
  Future<String?> read({required String key}) async => values[key];

  @override
  Future<void> write({required String key, required String value}) async =>
      values[key] = value;

  @override
  Future<void> delete({required String key}) async => values.remove(key);
}

/// Records every request and replies with [statusCode] and [body].
class FakeAdapter() implements dio.HttpClientAdapter {
  final requests = <dio.RequestOptions>[];

  int statusCode = 200;
  Object? body = <String, dynamic>{};

  dio.RequestOptions get lastRequest => requests.last;

  @override
  Future<dio.ResponseBody> fetch(
    dio.RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);

    return dio.ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      statusMessage: 'status $statusCode',
      headers: {
        dio.Headers.contentTypeHeader: [dio.Headers.jsonContentType],
        'x-test': ['value'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
