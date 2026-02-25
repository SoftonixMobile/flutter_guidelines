import 'package:data_provider/network.dart';

typedef JsonMap = Map<String, dynamic>;
typedef JsonConverter<T> = T Function(JsonMap);

class JsonDataParser implements JsonParser {
  final _converters = <Type, Function(dynamic)>{};

  JsonDataParser() {
    // Register default converters if needed
  }

  @override
  void registerType<T>(JsonConverter<T> converter) {
    _converters[T] = (input) => converter(input);
    _converters[List<T>] = (input) =>
        (input as List).map((e) => converter(e)).toList();
  }

  @override
  void unregisterType<T>() => _converters
    ..remove(T)
    ..remove(List<T>);

  bool isTypeRegistered<T>() => _converters[T] != null;

  @override
  T parse<T>(dynamic input) {
    final converter = _converters[T];

    if (converter != null) {
      return converter(input);
    } else {
      return input;
    }
  }
}
