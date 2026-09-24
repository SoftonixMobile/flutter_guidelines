class NetworkOptions({
  var String? method,
  var Duration? sendTimeout,
  var Duration? receiveTimeout,
  var Duration? connectTimeout,
  var Map<String, Object?>? extra,
  var Map<String, Object?>? headers,
  var bool? preserveHeaderCase,
  var String? contentType,
  var bool? receiveDataWhenStatusError,
  var bool? followRedirects,
  var int? maxRedirects,
});
