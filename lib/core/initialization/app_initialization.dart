import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/blocs/bloc_observer.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  initializeSplashScreen(widgetsBinding);
  await initializeLocalization();

  final logger = await initializeLogger();
  initializeCrashlytics(logger);
  initializeBlocObserver(logger);
  initializeDependencies(logger);
}

void initializeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

Future<void> initializeLocalization() {
  return EasyLocalization.ensureInitialized();
}

Future<Logger> initializeLogger() async {
  final logger = MultiLogger([
    if (kDebugMode) ConsoleLogger(),
  ]);
  await logger.init();

  return logger;
}

void initializeDependencies(Logger logger) {
  return configureAuthDependencies(logger: logger);
}

void initializeCrashlytics(Logger logger) {
  FlutterError.onError = (errorDetails) {
    logger.logError(errorDetails.exception, errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.logError(error, stack);

    return true;
  };
}

void initializeBlocObserver(Logger logger) {
  Bloc.observer = SimpleBlocObserver(logger);
}
