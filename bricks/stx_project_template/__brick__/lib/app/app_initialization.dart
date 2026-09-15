import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:{{project_name}}/blocs/bloc_observer.dart';
import 'package:{{project_name}}/core/index.dart';
import 'package:{{project_name}}/services/index.dart';

Future<void> initializeApp() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  _initializeSplashScreen(widgetsBinding);
  await _initializeLogger();
  await _initializeLocalization();
  _initializeCrashlytics();
  _initializeBlocObserver();
  _initializeValidators();
  _initializeDependencies();
}

void _initializeSplashScreen(WidgetsBinding widgetsBinding) {
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
}

Future<void> _initializeLogger() {
  return LoggerService.instance.init();
}

Future<void> _initializeLocalization() {
  return EasyLocalization.ensureInitialized();
}

void _initializeCrashlytics() {
  FlutterError.onError = (errorDetails) {
    LoggerService.instance.logError(errorDetails.exception, errorDetails.stack);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    LoggerService.instance.logError(error, stack);

    return true;
  };
}

void _initializeBlocObserver() {
  Bloc.observer = SimpleBlocObserver(LoggerService.instance);
}

void _initializeValidators() {
  FieldBlocValidators.requiredValidator = FieldValidators.required;
  FieldBlocValidators.requiredBooleanValidator =
      FieldValidators.booleanRequired;
}

void _initializeDependencies() {
  configureAuthDependencies();
}
