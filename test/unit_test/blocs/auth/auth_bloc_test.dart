import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_guidelines/blocs/auth/auth_bloc.dart';
import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/repositories/index.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

// Tests for AuthBloc using bloc_test lib
void main() {
  const fullUserProfile = UserProfile(userName: 'test');

  // Define mock instance with uses for all tests
  late AuthRepository mockAuthRepo;
  late UserRepository mockUserRepo;

  group('Auth bloc tests', () {
    // Creating mock instance for each test
    setUp(() {
      mockAuthRepo = _MockAuthRepository();
      mockUserRepo = _MockUserRepository();

      // Using 'when' method for simulate fake call
      // Mock the authentication status stream
      when(() => mockAuthRepo.authenticationStatus).thenAnswer((_) {
        return const Stream<AuthStatus>.empty();
      });
    });

    blocTest(
      'Initial state',
      setUp: () {
        when(() => mockAuthRepo.authenticationStatus).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.initial);
        });
      },
      // Provide creating bloc method here
      // (its better to create new instance of bloc for each test
      // to avoid mess up)
      build: () => AuthBloc(
        authRepository: mockAuthRepo,
        userRepository: mockUserRepo,
      ),
      // Here you only need to specify states which you receive from bloc
      // in right order
      expect: () => [const AuthState()],
    );

    blocTest(
      'Authenticated state',
      setUp: () {
        when(() => mockAuthRepo.authenticationStatus).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.authenticated);
        });

        when(
          mockUserRepo.getUserProfile,
        ).thenAnswer((_) async => fullUserProfile);
      },
      build: () => AuthBloc(
        authRepository: mockAuthRepo,
        userRepository: mockUserRepo,
      ),
      expect: () => [AuthState.authenticated(fullUserProfile)],
    );

    blocTest(
      'Unauthenticated state when getUserProfile throws error',
      setUp: () {
        when(() => mockAuthRepo.authenticationStatus).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.authenticated);
        });

        when(mockUserRepo.getUserProfile).thenThrow(UnimplementedError());
      },
      build: () => AuthBloc(
        authRepository: mockAuthRepo,
        userRepository: mockUserRepo,
      ),
      expect: () => [AuthState.unauthenticated()],
    );

    blocTest(
      'Unauthenticated state',
      setUp: () {
        when(() => mockAuthRepo.authenticationStatus).thenAnswer((_) {
          return Stream<AuthStatus>.value(AuthStatus.unauthenticated);
        });
      },
      build: () => AuthBloc(
        authRepository: mockAuthRepo,
        userRepository: mockUserRepo,
      ),
      expect: () => [AuthState.unauthenticated()],
    );

    blocTest(
      'Sign out',
      setUp: () {
        when(
          mockAuthRepo.signOut,
        ).thenAnswer((_) async => {});
      },
      build: () => AuthBloc(
        authRepository: mockAuthRepo,
        userRepository: mockUserRepo,
      ),
      // Set the previous state in a bloc for testing specific cases
      // without unnecessary actions
      // (to prevent test failure due to unrelated methods)
      seed: () => AuthState.authenticated(fullUserProfile),
      act: (bloc) {
        bloc
          ..add(const AuthEvent.signOut())
          ..add(
            const AuthEvent.authenticationStatusChanged(
              AuthStatus.unauthenticated,
            ),
          );
      },
      // Verify that signOut method was called
      verify: (bloc) {
        verify(mockAuthRepo.signOut).called(1);
      },
      expect: () => [AuthState.unauthenticated()],
    );
  });
}
