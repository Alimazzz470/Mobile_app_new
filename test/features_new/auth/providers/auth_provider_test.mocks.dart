import 'package:mockito/mockito.dart';
import 'package:taxiapp_mobile/core/entities/user.dart';
import 'package:taxiapp_mobile/features_new/auth/repositories/auth_repository.dart';
import 'package:taxiapp_mobile/network/clients/cancel_token.dart';
import 'package:taxiapp_mobile/shared/utils/result.dart';

// Manual mock implementation since build_runner cannot be executed in this environment.
class MockAuthenticationRepository extends Mock implements AuthenticationRepository {
  @override
  FutureResult<User> signIn(String? email, String? password, String? fcmToken, [CancellationToken? cancelToken]) {
    return super.noSuchMethod(
      Invocation.method(#signIn, [email, password, fcmToken, cancelToken]),
      returnValue: Future.value(const Failure(AppException.unknownError("Mock Failure"))),
      returnValueForMissingStub: Future.value(const Failure(AppException.unknownError("Mock Failure"))),
    ) as FutureResult<User>;
  }

  @override
  FutureResult<User> me([CancellationToken? cancelToken]) {
    return super.noSuchMethod(
      Invocation.method(#me, [cancelToken]),
      returnValue: Future.value(User.empty() as Result<User, Exception>), // Cast for type safety in mock
    ) as FutureResult<User>;
  }

  // Implement other methods as needed or leave them to throw if not used
}
