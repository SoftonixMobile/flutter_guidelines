import 'dart:async';

import 'package:flutter_guidelines/core/logger/logger.dart';

class MultiLogger extends Logger {
  final List<Logger> _loggers;

  MultiLogger(this._loggers);

  @override
  Future<void> init() {
    return Future.wait(_loggers.map((logger) => logger.init()));
  }

  @override
  void registerUser({
    required int id,
    required String userName,
  }) {
    for (final logger in _loggers) {
      logger.registerUser(id: id, userName: userName);
    }
  }

  @override
  void log(String message, {String? category}) {
    for (final logger in _loggers) {
      try {
        logger.log(message, category: category);
      } catch (error, stackTrace) {
        logError(error, stackTrace);
      }
    }
  }

  @override
  void logInfo(String message) {
    for (final logger in _loggers) {
      try {
        logger.logInfo(message);
      } catch (error, stackTrace) {
        logError(error, stackTrace);
      }
    }
  }

  @override
  void logWarning(String message) {
    for (final logger in _loggers) {
      try {
        logger.logWarning(message);
      } catch (error, stackTrace) {
        logError(error, stackTrace);
      }
    }
  }

  @override
  void logError(Object exception, [dynamic stackTrace]) {
    for (final logger in _loggers) {
      try {
        logger.logError(exception, stackTrace);
      } catch (_) {}
    }
  }
}
