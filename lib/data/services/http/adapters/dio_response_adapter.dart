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
