import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patrol/patrol.dart';
import 'package:stx_flutter_form_bloc/stx_flutter_form_bloc.dart';

import 'package:flutter_guidelines/screens/login/login_form_bloc.dart';
import 'package:flutter_guidelines/screens/login/login_screen.dart';
import 'package:flutter_guidelines/screens/login/widgets/index.dart';

class MockLoginFormBloc extends Mock implements LoginFormBloc {}

void main() {
  patrolWidgetTest(
    'Check widgets',
    ($) async {
      /// Mock bloc interactions.
      final formBloc = MockLoginFormBloc();

      when(() => formBloc.stream).thenAnswer((_) => const Stream.empty());
      when(() => formBloc.state).thenAnswer((_) => FormBlocState());
      when(() => formBloc.username).thenAnswer((_) => TextFieldBloc());
      when(() => formBloc.password).thenAnswer((_) => TextFieldBloc());
      when(formBloc.close).thenAnswer((_) async {});

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginFormBloc>(
            create: (_) => formBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      /// Test if needed elements are present.
      final logo = $(Image);
      final emailField = $(#username);
      final passwordField = $(#password);
      final loginButton = $(LoginButton);

      expect(logo, findsOneWidget);
      expect(emailField, findsOneWidget);
      expect(passwordField, findsOneWidget);
      expect(loginButton, findsOneWidget);
    },
  );

  patrolWidgetTest(
    'Check errors',
    ($) async {
      /// Mock bloc interactions.
      final formBloc = MockLoginFormBloc();
      final username = TextFieldBloc(
        required: true,
        rules: {ValidationType.onBlur},
      );

      final password = TextFieldBloc(
        required: true,
        // Will be changed later
        // ignore: deprecated_member_use
        customValidators: {FieldBlocValidators.passwordMin6Chars},
        rules: {ValidationType.onBlur},
      );

      when(() => formBloc.stream).thenAnswer((_) => const Stream.empty());
      when(() => formBloc.state).thenAnswer((_) => FormBlocState());
      when(() => formBloc.username).thenAnswer((_) => username);
      when(() => formBloc.password).thenAnswer((_) => password);
      when(formBloc.close).thenAnswer((_) async {});

      when(formBloc.submit).thenAnswer((_) {
        username.validate();
        password.validate();
      });

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<LoginFormBloc>(
            create: (_) => formBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      /// Enter invalid data and submit it.
      await $(#username).enterText('test@user.com');
      await $(#password).enterText('1');

      await $(LoginButton).tap();

      await $.pump();

      /// Test if the error is present.
      const errorText = 'Password length must be at least 6 characters';
      final error = $(errorText);

      expect(error, findsOneWidget);
    },
  );
}
