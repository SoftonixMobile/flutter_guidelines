import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_guidelines/domain/models/index.dart';
import 'package:flutter_guidelines/domain/repositories/index.dart';
import 'package:flutter_guidelines/presentation/blocs/session/session_bloc.dart';

class _MockAuthRepository() extends Mock implements AuthRepository;

// Tests for SessionBloc using bloc_test lib
void main() {
  // Define mock instance with uses for all tests
  late AuthRepository mockAuthRepo;

  group('Session bloc tests', () {
    // Creating mock instance for each test
    setUp(() {
      mockAuthRepo = _MockAuthRepository();

      // Using 'when' method for simulate fake call
      // Mock the authentication status stream
      when(() => mockAuthRepo.onAuthStatusChanged).thenAnswer((_) {
        return const Stream<AuthStatus>.empty();
      });
    });

    blocTest(
      'Initial state',
      setUp: () {
        when(() => mockAuthRepo.onAuthStatusChanged).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.initial);
        });
      },
      // Provide creating bloc method here
      // (its better to create new instance of bloc for each test
      // to avoid mess up)
      build: () => SessionBloc(mockAuthRepo),
      act: (bloc) => bloc.add(const SessionEvent.subscribe()),
      // Here you only need to specify states which you receive from bloc
      // in right order
      expect: () => [const SessionState()],
    );

    blocTest(
      'Authenticated state',
      setUp: () {
        when(() => mockAuthRepo.onAuthStatusChanged).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.authenticated);
        });
      },
      build: () => SessionBloc(mockAuthRepo),
      act: (bloc) => bloc.add(const SessionEvent.subscribe()),
      expect: () => [SessionState.authenticated()],
    );

    blocTest(
      'Unauthenticated state',
      setUp: () {
        when(() => mockAuthRepo.onAuthStatusChanged).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.unauthenticated);
        });
      },
      build: () => SessionBloc(mockAuthRepo),
      act: (bloc) => bloc.add(const SessionEvent.subscribe()),
      expect: () => [SessionState.unauthenticated()],
    );

    late StreamController<AuthStatus> statusController;

    blocTest(
      'Sign out',
      setUp: () {
        statusController = StreamController<AuthStatus>();

        when(
          () => mockAuthRepo.onAuthStatusChanged,
        ).thenAnswer((_) => statusController.stream);

        // Simulate the session emitting unauthenticated after sign out
        when(mockAuthRepo.signOut).thenAnswer((_) async {
          statusController.add(.unauthenticated);
        });
      },
      tearDown: () => statusController.close(),
      build: () => SessionBloc(mockAuthRepo),
      // Set the previous state in a bloc for testing specific cases
      // without unnecessary actions
      seed: SessionState.authenticated,
      act: (bloc) => bloc
        ..add(const SessionEvent.subscribe())
        ..add(const SessionEvent.signOut()),
      // Verify that signOut method was called
      verify: (bloc) {
        verify(mockAuthRepo.signOut).called(1);
      },
      expect: () => [SessionState.unauthenticated()],
    );
  });
}
