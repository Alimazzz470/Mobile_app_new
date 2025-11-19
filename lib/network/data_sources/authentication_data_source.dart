import 'package:dio/dio.dart';
import '../../core/exceptions/exceptions.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/token_model.dart';
import '../models/user_model.dart';

class UserWithToken {
  final UserModel user;
  final TokenModel token;
  const UserWithToken({required this.user, required this.token});
}

class AuthenticationDataSource {
  final ApiClient _apiClient;
  const AuthenticationDataSource(this._apiClient);

  Future<UserWithToken> signIn(
    String email,
    String password,
    String fcmToken,
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.post(
        ApiConfig.login,
        body: {
          'email': email,
          'password': password,
          'fcmToken': fcmToken,
        },
        cancelToken: cancelToken,
      );
      if (res != null) {
        return UserWithToken(
          user: UserModel.fromJson(res.data['user']),
          token: TokenModel.fromJson(res.data['token']),
        );
      }
      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<UserModel> me(CancellationToken? cancelToken) async {
    var res = await _apiClient.get(
      ApiConfig.me,
      cancelToken: cancelToken,
    );
    if (res != null) {
      return UserModel.fromJson(res.data);
    }
    throw const NullDataException();
  }

  Future<void> signOut(CancellationToken? cancelToken) async {
    try {
      await _apiClient.post(
        ApiConfig.logout,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> updateFcmToken(
    String fcmToken,
    CancellationToken? cancelToken,
  ) async {
    try {
      await _apiClient.post(
        ApiConfig.updateFcmToken,
        body: {
          'fcmToken': fcmToken,
        },
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
