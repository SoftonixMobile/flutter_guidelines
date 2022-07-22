import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:flutter_guidelines/core/constants/app_constants.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'app.dart';
import 'bloc_observer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: AppConstants.dotenvFilePath);

  BlocOverrides.runZoned(
    () {
      configureDependencies();
      runApp(
        EasyLocalization(
          path: CodegenLoader.path,
          supportedLocales: CodegenLoader.supportedLocales,
          fallbackLocale: CodegenLoader.supportedLocales.last,
          assetLoader: const CodegenLoader(),
          child: SoftonixApp(),
        ),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}
