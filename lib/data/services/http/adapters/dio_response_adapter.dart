import 'package:data_provider/network.dart' as data;
import 'package:dio/dio.dart' as dio;

class DioResponseAdapter<T>(dio.Response<T> response) extends data.Response<T> {
  this
    : super(
        data: response.data,
        statusCode: response.statusCode ?? 0,
        statusMessage: response.statusMessage,
        headers: response.headers.map,
      );
}

extension DioResponseParser on dio.Response {
  dio.Response<T> parse<T>(data.JsonParser parser) {
    return dio.Response(
      data: parser.parse<T>(this.data),
      statusCode: statusCode,
      statusMessage: statusMessage,
      headers: headers,
      requestOptions: requestOptions,
    );
  }
}
