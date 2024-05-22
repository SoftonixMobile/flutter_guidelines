import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:{{project_name}}/blocs/bloc_observer.dart';
import 'package:{{project_name}}/services/index.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  initializeSplashScreen(widgetsBinding);
  await initializeDotenv();
  await initializeLogger();
  await initializeLocalization();
  initializeCrashlytics();
  initializeBlocObserver();
  configureAuthDependencies();
}

void initializeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

Future<void> initializeLogger() {
  return LoggerService.instance.init();
}

Future<void> initializeLocalization() {
  return EasyLocalization.ensureInitialized();
}

Future<void> initializeDotenv() {
  return dotenv.load();
}

void initializeCrashlytics() {
  FlutterError.onError = (errorDetails) {
    LoggerService.instance.logError(errorDetails.exception, errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    LoggerService.instance.logError(error, stack);

    return true;
  };
}

void initializeBlocObserver() {
  Bloc.observer = SimpleBlocObserver(LoggerService.instance);
}
