import 'package:data_provider/data_provider.dart';
import 'package:data_provider/network.dart' as data;
import 'package:dio/dio.dart' as dio;

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
  dio.Response parse<T>(IJsonParser parser) {
    return dio.Response(
      data: parser.convert<T>(this.data),
      statusCode: statusCode,
      statusMessage: statusMessage,
      headers: headers,
      requestOptions: requestOptions,
    );
  }
}
