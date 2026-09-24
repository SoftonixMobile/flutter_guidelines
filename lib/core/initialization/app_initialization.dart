import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:material_ui/material_ui.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/data/services/index.dart';
import 'package:flutter_guidelines/presentation/blocs/index.dart';
import 'package:flutter_guidelines/presentation/localization/index.dart';
import 'package:flutter_guidelines/presentation/utils/index.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  _initializeSplashScreen(widgetsBinding);
  await _initializeLocalization();

  final logger = await _initializeLogger();
  _initializeCrashlytics(logger);
  _initializeBlocObserver(logger);
  _initializeDependencies(logger);
  _initializeValidators();
}

void _initializeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

Future<void> _initializeLocalization() {
  return EasyLocalization.ensureInitialized();
}

Future<Logger> _initializeLogger() async {
  final logger = MultiLogger([
    if (kDebugMode) ConsoleLogger(),
  ]);
  await logger.init();

  return logger;
}

void _initializeCrashlytics(Logger logger) {
  FlutterError.onError = (errorDetails) {
    logger.logError(errorDetails.exception, errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    logger.logError(error, stack);

    return true;
  };
}

void _initializeBlocObserver(Logger logger) {
  Bloc.observer = SimpleBlocObserver(logger);
}

void _initializeDependencies(Logger logger) {
  return configureAuthDependencies(logger: logger);
}

void _initializeValidators() {
  FieldBlocValidators.requiredValidator = FieldValidators.required;
  FieldBlocValidators.requiredBooleanValidator =
      FieldValidators.booleanRequired;
}
