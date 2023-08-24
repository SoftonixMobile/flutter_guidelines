// ignore_for_file: avoid_print

import '../index.dart';

class ConsoleLogger extends Logger {
  ConsoleLogger();

  @override
  void log(String message, {String? category}) {
    print(message);
  }

  @override
  void logInfo(String message) {
    print('INFO:$message');
  }

  @override
  void logWarning(String message) {
    print('WARNING: $message');
  }

  @override
  void logError(Object exception, [dynamic stackTrace]) {
    print('ERROR: $exception');
  }
}
