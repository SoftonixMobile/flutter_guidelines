abstract class IJsonParser {
  void registerType<T>(T Function(Map<String, dynamic>) fromJson);

  void unregisterType<T>();

  T convert<T>(dynamic input);
}
