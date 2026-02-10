class NetworkOptions {
  String? method;
  Duration? sendTimeout;
  Duration? receiveTimeout;
  Duration? connectTimeout;
  Map<String, Object?>? extra;
  Map<String, Object?>? headers;
  bool? preserveHeaderCase;
  String? contentType;
  bool? receiveDataWhenStatusError;
  bool? followRedirects;
  int? maxRedirects;

  NetworkOptions({
    this.method,
    this.sendTimeout,
    this.receiveTimeout,
    this.connectTimeout,
    this.extra,
    this.headers,
    this.preserveHeaderCase,
    this.contentType,
    this.receiveDataWhenStatusError,
    this.followRedirects,
    this.maxRedirects,
  });
}
