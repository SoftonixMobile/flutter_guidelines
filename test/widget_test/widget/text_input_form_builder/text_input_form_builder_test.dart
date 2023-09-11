import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/widgets/form_builder/index.dart';

Future<void> main() async {
  /// Init EasyLocalization.
  SharedPreferences.setMockInitialValues({});
  await EasyLocalization.ensureInitialized();

  /// Call ensureInitialized, because main is async.
  TestWidgetsFlutterBinding.ensureInitialized();

  patrolWidgetTest(
    'Text field error',
    ($) async {
      /// Mock bloc interactions.
      final bloc = TextFieldBloc(
        required: true,
        rules: {ValidationType.onChange},
        customValidators: {FieldBlocValidators.passwordMin6Chars},
      );

      /// Get the widget.
      await $.pumpWidget(
        EasyLocalization(
          path: CodegenLoader.path,
          supportedLocales: CodegenLoader.supportedLocales,
          fallbackLocale: CodegenLoader.supportedLocales.last,
          assetLoader: const CodegenLoader(),
          child: MaterialApp(
            home: Material(
              child: TextInputFormBuilder(fieldBloc: bloc),
            ),
          ),
        ),
      );

      /// Test if needed elements are present.
      final textField = $(TextField);
      expect(textField, findsOneWidget);

      await textField.enterText('12');
      await $.pump();

      final error = $('Password length must be at least 6 characters');
      expect(error, findsOneWidget);
    },
  );
}
