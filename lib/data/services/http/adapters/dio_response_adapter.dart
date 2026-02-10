import 'package:data_provider/network.dart' as data;
import 'package:dio/dio.dart' as dio;

import '../json_data_parser.dart';

class DioResponseAdapter<T> extends data.Response<T> {
  DioResponseAdapter(dio.Response response)
    : super(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage,
        headers: response.headers.map,
      );
}

extension DioResponseParser on dio.Response {
  dio.Response parse<T>(JsonDataParser parser) {
    return dio.Response(
      data: parser.convert<T>(this.data),
      statusCode: statusCode,
      statusMessage: statusMessage,
      headers: headers,
      requestOptions: requestOptions,
    );
  }
}
