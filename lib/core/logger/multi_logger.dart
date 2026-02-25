import 'dart:async';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'base/logger.dart';

class MultiLogger extends Logger {
  final List<Logger> _loggers;

  MultiLogger(this._loggers);

  @override
  Future<void> init() {
    return Future.wait(_loggers.map((logger) => logger.init()));
  }

  @override
  void registerUserProfile(UserProfile userProfile) {
    for (final logger in _loggers) {
      logger.registerUserProfile(userProfile);
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
