class RequestOptions({
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
}) {
  static const Duration _longSendTimeout = Duration(minutes: 2);
  static const Duration _longReceiveTimeout = Duration(seconds: 90);

  /// For requests that send a file.
  new longSend() : this(sendTimeout: _longSendTimeout);

  /// For requests whose response the server has to produce or stream.
  new longReceive() : this(receiveTimeout: _longReceiveTimeout);

  /// For requests that do both — upload a file, then wait on generated output.
  new longSendReceive()
    : this(
        sendTimeout: _longSendTimeout,
        receiveTimeout: _longReceiveTimeout,
      );
}
