import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';
import 'package:flutter_guidelines/presentation/blocs/auth/auth_bloc.dart';

class _MockAuthRepository() extends Mock implements AuthRepository;

// Tests for AuthBloc using bloc_test lib
void main() {
  // Define mock instance with uses for all tests
  late AuthRepository mockAuthRepo;

  group('Auth bloc tests', () {
    // Creating mock instance for each test
    setUp(() {
      mockAuthRepo = _MockAuthRepository();

      // Using 'when' method for simulate fake call
      // Mock the authentication status stream
      when(() => mockAuthRepo.onStatusChanged).thenAnswer((_) {
        return const Stream<AuthStatus>.empty();
      });
    });

    blocTest(
      'Initial state',
      setUp: () {
        when(() => mockAuthRepo.onStatusChanged).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.initial);
        });
      },
      // Provide creating bloc method here
      // (its better to create new instance of bloc for each test
      // to avoid mess up)
      build: () => AuthBloc(mockAuthRepo),
      act: (bloc) => bloc.add(const AuthEvent.subscribe()),
      // Here you only need to specify states which you receive from bloc
      // in right order
      expect: () => [const AuthState()],
    );

    blocTest(
      'Authenticated state',
      setUp: () {
        when(() => mockAuthRepo.onStatusChanged).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.authenticated);
        });
      },
      build: () => AuthBloc(mockAuthRepo),
      act: (bloc) => bloc.add(const AuthEvent.subscribe()),
      expect: () => [AuthState.authenticated()],
    );

    blocTest(
      'Unauthenticated state',
      setUp: () {
        when(() => mockAuthRepo.onStatusChanged).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.unauthenticated);
        });
      },
      build: () => AuthBloc(mockAuthRepo),
      act: (bloc) => bloc.add(const AuthEvent.subscribe()),
      expect: () => [AuthState.unauthenticated()],
    );

    late StreamController<AuthStatus> statusController;

    blocTest(
      'Sign out',
      setUp: () {
        statusController = StreamController<AuthStatus>();

        when(
          () => mockAuthRepo.onStatusChanged,
        ).thenAnswer((_) => statusController.stream);

        // Simulate the session emitting unauthenticated after sign out
        when(mockAuthRepo.signOut).thenAnswer((_) async {
          statusController.add(.unauthenticated);
        });
      },
      tearDown: () => statusController.close(),
      build: () => AuthBloc(mockAuthRepo),
      // Set the previous state in a bloc for testing specific cases
      // without unnecessary actions
      seed: AuthState.authenticated,
      act: (bloc) => bloc
        ..add(const AuthEvent.subscribe())
        ..add(const AuthEvent.signOut()),
      // Verify that signOut method was called
      verify: (bloc) {
        verify(mockAuthRepo.signOut).called(1);
      },
      expect: () => [AuthState.unauthenticated()],
    );
  });
}
