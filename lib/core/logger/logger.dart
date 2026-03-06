abstract class Logger {
  Future<void> init() async {}

  void registerUser({
    required int id,
    required String userName,
  }) {}

  void log(String message, {String? category});

  void logInfo(String message);

  void logWarning(String message);

  void logError(Object exception, [dynamic stackTrace]);
}
