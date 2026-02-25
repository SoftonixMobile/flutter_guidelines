abstract class JsonParser {
  void registerType<T>(T Function(Map<String, dynamic>) fromJson);

  void unregisterType<T>();

  T parse<T>(dynamic input);
}
