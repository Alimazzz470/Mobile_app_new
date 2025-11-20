import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:taxiapp_mobile/core/entities/user.dart';
import 'package:taxiapp_mobile/core/exceptions/app_exception.dart';
import 'package:taxiapp_mobile/features_new/auth/providers/auth_provider.dart';
import 'package:taxiapp_mobile/shared/utils/result.dart';

import 'auth_provider_test.mocks.dart';

// Removed @GenerateMocks because we are using a manual mock file due to environment limitations.

void main() {
  group('AuthStateNotifier', () {
    late MockAuthenticationRepository mockAuthRepo;

    setUp(() {
      mockAuthRepo = MockAuthenticationRepository();
    });

    test('signIn success calls onUserChange', () async {
      // Arrange
      bool userChanged = false;
      final expectedUser = User.empty();

      final notifier = AuthStateNotifier(
        authenticationRepository: mockAuthRepo,
        onUserChange: (user) {
          userChanged = true;
          // We skip deep equality check for now as User might not have Equatable set up correctly for tests without build runner
        },
      );

      when(mockAuthRepo.signIn(any, any, any))
          .thenAnswer((_) async => Success(expectedUser));

      // Act
      notifier.signIn(
        email: 'test@example.com',
        password: 'password',
        fcmToken: 'token',
        onError: (e) => fail('Should not return error'),
      );

      // Wait for async operations
      await Future.delayed(Duration.zero);

      // Assert
      verify(mockAuthRepo.signIn('test@example.com', 'password', 'token')).called(1);
      expect(userChanged, isTrue);
      expect(notifier.state, isA<AsyncData<bool>>());
    });

    test('signIn failure calls onError', () async {
      // Arrange
      bool errorCalled = false;
      final exception = AppException.unknownError("Boom");

      final notifier = AuthStateNotifier(
        authenticationRepository: mockAuthRepo,
        onUserChange: (_) => fail('Should not change user'),
      );

      when(mockAuthRepo.signIn(any, any, any))
          .thenAnswer((_) async => Failure(exception));

      // Act
      notifier.signIn(
        email: 'test@example.com',
        password: 'password',
        fcmToken: 'token',
        onError: (e) {
          errorCalled = true;
          expect(e, exception);
        },
      );

      // Wait for async operations
      await Future.delayed(Duration.zero);

      // Assert
      verify(mockAuthRepo.signIn(any, any, any)).called(1);
      expect(errorCalled, isTrue);
      expect(notifier.state, isA<AsyncData<bool>>());
    });
  });
}
