import 'package:data_provider/network.dart' as data;
import 'package:dio/dio.dart' as dio;

class RequestOptionsAdapter extends dio.Options {
  RequestOptionsAdapter(data.NetworkOptions options)
    : super(
        method: options.method,
        sendTimeout: options.sendTimeout,
        receiveTimeout: options.receiveTimeout,
        extra: options.extra,
        headers: options.headers,
        preserveHeaderCase: options.preserveHeaderCase,
        contentType: options.contentType,
        receiveDataWhenStatusError: options.receiveDataWhenStatusError,
        followRedirects: options.followRedirects,
        maxRedirects: options.maxRedirects,
      );

  static RequestOptionsAdapter? fromOptional(data.NetworkOptions? options) {
    if (options == null) return null;

    return RequestOptionsAdapter(options);
  }
}
