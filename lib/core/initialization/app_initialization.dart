import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/presentation/blocs/bloc_observer.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  initializeSplashScreen(widgetsBinding);
  await initializeLocalization();
  await initializeDependencies();
  initializeCrashlytics();
  initializeBlocObserver();
}

void initializeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

Future<void> initializeLocalization() {
  return EasyLocalization.ensureInitialized();
}

Future<void> initializeDependencies() {
  return configureAuthDependencies();
}

void initializeCrashlytics() {
  FlutterError.onError = (errorDetails) {
    getIt<Logger>().logError(errorDetails.exception, errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    getIt<Logger>().logError(error, stack);

    return true;
  };
}

void initializeBlocObserver() {
  Bloc.observer = SimpleBlocObserver(getIt<Logger>());
}
