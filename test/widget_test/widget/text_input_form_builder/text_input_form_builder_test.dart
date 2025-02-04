import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/widgets/form_builder/index.dart';

Future<void> main() async {
  patrolWidgetTest(
    'Text field error',
    ($) async {
      /// Mock bloc interactions.
      final bloc = TextFieldBloc(
        required: true,
        rules: {ValidationType.onChange},
        // Will be changed later
        // ignore: deprecated_member_use
        customValidators: {FieldBlocValidators.passwordMin6Chars},
      );

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: Material(
            child: TextInputFormBuilder(fieldBloc: bloc),
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
