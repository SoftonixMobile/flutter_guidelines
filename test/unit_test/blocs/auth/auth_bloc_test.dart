import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_guidelines/blocs/auth/auth_bloc.dart';
import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/repositories/index.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_bloc_test.mocks.dart';

// Annotation which generates .mocks.dart library and the Mock class.
@GenerateNiceMocks([MockSpec<AuthRepository>()])
@GenerateNiceMocks([MockSpec<UserRepository>()])
@GenerateNiceMocks([MockSpec<HttpClient>()])

/// Tests for Auth Bloc using bloc_test lib
void main() {
  /// Define test credential for login .
  /// If you have specific requirements, for test failure login
  /// define its inside  needed test
  const testEmail = 'test';
  const testPassword = 'password';

  const fullUserProfile = UserProfile(userName: 'test');

  /// Defining state for success login to simplify code
  const authenticatedState = AuthState(
    status: AuthenticationStatus.authenticated,
    userProfile: fullUserProfile,
  );

  /// Defining state for success logout to simplify code
  final unauthenticatedState = AuthState.unauthenticated();

  /// Define mock instance with uses for all tests
  final mockAuthRepo = MockAuthRepository();
  final authRepo = AuthRepository(MockHttpClient());
  final mockUserRepo = MockUserRepository();

  late AuthBloc authBloc;

  group('Auth bloc tests', () {
    ///Creating bloc forEach test
    setUp(() {
      authBloc =
          AuthBloc(authRepository: mockAuthRepo, userRepository: mockUserRepo);
    });

    /// Test for bloc initialization ,
    /// If you have complex init method it would be helpfully
    blocTest(
      'Successful initialization ',
      build: () => authBloc,
      expect: () => [],
    );

    /// Test for success sing in flow,
    /// GIVEN no user is log in
    /// WHEN call signIn method with right credential
    /// THEN state should be {authenticated}
    blocTest(
      'Successful sing in',

      // Provide creating bloc method here
      // (its better to create new instance of bloc for each test
      // to avoid mess up)
      build: () => authBloc,
      // Set actions which you should do for test
      act: (bloc) {
        //Using 'when' method for simulate fake call
        when(mockUserRepo.getUserProfile())
            .thenAnswer((realInvocation) async => fullUserProfile);

        //Using 'when' method for simulate fake call
        authRepo.signIn(testEmail, testPassword);

        bloc.add(
          const AuthEvent.authenticationStatusChanged(
            AuthenticationStatus.authenticated,
          ),
        );
      },

      // Set duration to wait before check result
      wait: const Duration(milliseconds: 200),

      // Here you only need to specify states which you receive from bloc
      // in right order
      expect: () => [authenticatedState],
    );

    /// Test unsuccessful signIn attempt
    /// GIVEN no user is log in
    /// WHEN call signIn method with wrong credential
    /// THEN state should be {unauthenticated}
    blocTest(
      'Failure sing in  ',

      // Provide creating bloc method here
      build: () => authBloc,
      // Set actions which you should do for test
      act: (bloc) {
        when(mockUserRepo.getUserProfile()).thenThrow(UnimplementedError());
        authRepo.signIn(testEmail, testPassword);
        bloc.add(
          const AuthEvent.authenticationStatusChanged(
            AuthenticationStatus.authenticated,
          ),
        );
      },

      // Set duration to wait before check result
      wait: const Duration(milliseconds: 200),

      // Here you only need to specify the states
      // that you want to get from the bloc in the correct order
      expect: () => [unauthenticatedState],
    );

    /// Test successful signOut attempt
    /// GIVEN user is log in
    /// WHEN call signOut method
    /// THEN state should be {unauthenticated}
    blocTest(
      'Successful Sing out ',
      build: () => authBloc,

      //Set the previous state in a bloc for testing specific cases
      //without unnecessary actions
      //(to prevent test failure due to unrelated methods)
      seed: () => authenticatedState,
      act: (bloc) {
        authRepo.signOut();

        bloc.add(
          const AuthEvent.authenticationStatusChanged(
            AuthenticationStatus.unauthenticated,
          ),
        );
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [unauthenticatedState],
    );
  });
}
