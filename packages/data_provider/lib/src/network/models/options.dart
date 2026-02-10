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
}
