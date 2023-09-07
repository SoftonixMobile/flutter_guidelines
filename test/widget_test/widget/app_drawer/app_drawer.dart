import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/widgets/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateNiceMocks([MockSpec<AuthBloc>()])
import 'app_drawer.mocks.dart';

Future<void> main() async {
  /// Init EasyLocalization.
  SharedPreferences.setMockInitialValues({});
  await EasyLocalization.ensureInitialized();

  /// Call ensureInitialized, because main is async.
  TestWidgetsFlutterBinding.ensureInitialized();

  patrolWidgetTest(
    'Check widgets',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockAuthBloc();

      /// Get the widget.
      await $.pumpWidget(
        EasyLocalization(
          path: CodegenLoader.path,
          supportedLocales: CodegenLoader.supportedLocales,
          fallbackLocale: CodegenLoader.supportedLocales.last,
          assetLoader: const CodegenLoader(),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                home: BlocProvider<MockAuthBloc>(
                  create: (_) => bloc,
                  child: const AppDrawer(),
                ),
              );
            },
          ),
        ),
      );

      await $.pump();

      /// Test if needed elements are present.
      final image = $(CircleAvatar);
      final changePassword = $(LocaleKeys.changePassword.tr());
      final languageName = $(LocaleKeys.languageName.tr());
      final signOut = $(LocaleKeys.signOut.tr());
      final icons = $(Icon);

      expect(image, findsOneWidget);
      expect(changePassword, findsOneWidget);
      expect(languageName, findsOneWidget);
      expect(signOut, findsOneWidget);
      expect(icons, findsNWidgets(3));
    },
  );

  patrolWidgetTest(
    'Check change localization',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockAuthBloc();

      /// Get the widget.
      await $.pumpWidget(
        EasyLocalization(
          path: CodegenLoader.path,
          supportedLocales: CodegenLoader.supportedLocales,
          fallbackLocale: CodegenLoader.supportedLocales.last,
          assetLoader: const CodegenLoader(),
          child: Builder(
            builder: (context) {
              return MaterialApp(
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                localizationsDelegates: context.localizationDelegates,
                home: BlocProvider<MockAuthBloc>(
                  create: (_) => bloc,
                  child: const AppDrawer(),
                ),
              );
            },
          ),
        ),
      );

      await $.pump();

      /// Checking if the button is initially in English.
      const englishSignOutText = 'Sign Out';
      var signOut = $(englishSignOutText);

      expect(signOut, findsOneWidget);

      /// Switch locale (from en_US to fr_FR).
      await $(LocaleKeys.languageName.tr()).tap();

      await $.pump();

      // Check if there is French text.
      //
      // Can also be checked via EasyLocalization.of(context).locale,
      // but it requires context.
      const frenchSignOutText = 'Se déconnecter';
      signOut = $(frenchSignOutText);

      expect(signOut, findsOneWidget);
    },
  );
}
