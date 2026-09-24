class Response<T>({
  required final T? data,
  required final int statusCode,
  required final String? statusMessage,
  required final Map<String, List<String>> headers,
});
