import 'app_exception.dart';

class const ConfigException({super.message}) extends AppException {
  @override
  String toString() => 'ConfigException: $message';
}
