import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/blocs/bloc_observer.dart';
import 'package:flutter_guidelines/core/index.dart';
import 'package:flutter_guidelines/services/index.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  initializeSplashScreen(widgetsBinding);
  await initializeLogger();
  await initializeLocalization();
  initializeCrashlytics();
  initializeBlocObserver();
  initializeValidators();
  initializeDependencies();
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

void initializeValidators() {
  FieldBlocValidators.requiredValidator = FieldValidators.required;
  FieldBlocValidators.requiredBooleanValidator = FieldValidators.booleanRequired;
}

void initializeDependencies() {
  configureAuthDependencies();
}
