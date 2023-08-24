// ignore_for_file: prefer_constructors_over_static_methods

import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_guidelines/models/index.dart';
import '../index.dart';

class LoggerService extends Logger {
  static Logger? _instance;
  static Logger get instance => _instance ??= LoggerService._();

  final List<Logger> loggers = [];

  LoggerService._() {
    if (kReleaseMode) {
      loggers.addAll([]);
    } else {
      loggers.addAll([
        ConsoleLogger(),
      ]);
    }
  }

  @override
  Future<void> init() {
    return Future.wait(loggers.map((logger) => logger.init()));
  }

  @override
  void registerUserProfile(UserProfile userProfile) {
    for (final logger in loggers) {
      logger.registerUserProfile(userProfile);
    }
  }

  @override
  void log(String message, {String? category}) {
    for (final logger in loggers) {
      try {
        logger.log(message, category: category);
      } catch (error, stackTrace) {
        logError(error, stackTrace);
      }
    }
  }

  @override
  void logInfo(String message) {
    for (final logger in loggers) {
      try {
        logger.logInfo(message);
      } catch (error, stackTrace) {
        logError(error, stackTrace);
      }
    }
  }

  @override
  void logWarning(String message) {
    for (final logger in loggers) {
      try {
        logger.logWarning(message);
      } catch (error, stackTrace) {
        logError(error, stackTrace);
      }
    }
  }

  @override
  void logError(Object exception, [dynamic stackTrace]) {
    for (final logger in loggers) {
      try {
        logger.logError(exception, stackTrace);
      } catch (_) {}
    }
  }
}
