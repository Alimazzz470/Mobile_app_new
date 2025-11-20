import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../core/exceptions/exceptions.dart';
import '../../core/exceptions/forbidden_exception.dart';
import '../../core/exceptions/no_stored_token_exception.dart';
import '../../core/services/connectivity/connection_manager.dart';
import '../api_config.dart';
import '../data_sources/token_data_source.dart';
import '../models/token_model.dart';

class ApiClient {
  final ConnectivityManager connectivity;
  final TokenDataSource tokenDataSource;
  late final Dio _baseAPI;

  ApiClient({
    required this.connectivity,
    required this.tokenDataSource,
    required String baseUrl,
  }) {
    _baseAPI = _addInterceptors(Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    )));
  }

  Dio _addInterceptors(Dio dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          handler.next(await _requestInterceptor(options));
        },
      ),
    );

    // Can add retry interceptor as well [dio_smart_retry]

    if (kDebugMode) {
      dio.interceptors.add(PrettyDioLogger(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        responseHeader: false,
        request: true,
        error: true,
      ));
    }
    return dio;
  }

  Future<RequestOptions> _requestInterceptor(RequestOptions options) async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

    String idToken = await _getToken();
    Map<String, dynamic> requestHeaders = {
      'Content-Type': "application/json",
      'X-Timezone': currentTimeZone
    };

    if (idToken.isNotEmpty) {
      requestHeaders["Authorization"] = idToken;
    }

    options.headers.addAll(requestHeaders);
    return options;
  }

  Future<String> _getToken() async {
    try {
      var token = await tokenDataSource.get();
      if (token.hasExpired) {
        // Try to refresh token here and assign new token
        token = await _refreshToken(token);
      }
      return 'Bearer ${token.accessToken}';
    } on NoStoredTokenException {
      // No token exists at this point. User is signing in/up
      return "";
    } on NotRefreshedTokenException {
      // Token cannot be refreshed, kick out of app via facade
      await tokenDataSource.clear();
      return "";
    } catch (e, _) {
      // Unhandled error happened
      return "";
    }
  }

  Future<TokenModel> _refreshToken(TokenModel oldToken) async {
    try {
      var dio = Dio(BaseOptions(
        baseUrl: _baseAPI.options.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ));

      var res = await dio.post(
        ApiConfig.refreshToken,
        data: jsonEncode({
          'accessToken': oldToken.accessToken,
          'refreshToken': oldToken.refreshToken,
        }),
      );
      return TokenModel.fromJson(res.data["token"]);
    } catch (_) {
      throw const NotRefreshedTokenException();
    }
  }

  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    if (!await connectivity()) {
      throw const NetworkException();
    }

    try {
      return await _baseAPI.get(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('Request canceled');
        throw const RequestCanceledException();
      }
      var statusCode = e.response?.statusCode ?? 0;
      // Handle any other error types
      if (statusCode >= 500) {
        throw ServerException(e.message);
      }

      if (statusCode == 403) {
        throw const ForbiddenException();
      }

      if (statusCode == 401) {
        throw const RequestCanceledException();
      }
      rethrow;
    }
  }

  Future<Response?> post(
    String url, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  }) async {
    if (!await connectivity()) {
      throw const NetworkException();
    }

    try {
      return await _baseAPI.post(
        url,
        cancelToken: cancelToken,
        data: body != null ? jsonEncode(body) : null,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('Request canceled');
        throw const RequestCanceledException();
      }
      var statusCode = e.response?.statusCode ?? 0;
      // Handle any other error types
      if (statusCode >= 500) {
        throw ServerException(e.message);
      }

      if (statusCode == 403) {
        throw const ForbiddenException();
      }

      if (statusCode == 401) {
        throw const RequestCanceledException();
      }
      rethrow;
    }
  }

  Future<Response?> patch(
    String url, {
    Map<String, dynamic>? body,
    CancelToken? cancelToken,
  }) async {
    if (!await connectivity()) {
      throw const NetworkException();
    }

    try {
      return await _baseAPI.patch(
        url,
        cancelToken: cancelToken,
        data: body != null ? jsonEncode(body) : null,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('Request canceled');
        throw const RequestCanceledException();
      }
      var statusCode = e.response?.statusCode ?? 0;
      // Handle any other error types
      if (statusCode >= 500) {
        throw ServerException(e.message);
      }

      if (statusCode == 403) {
        throw const ForbiddenException();
      }

      if (statusCode == 401) {
        throw const RequestCanceledException();
      }
      rethrow;
    }
  }

  Future<Response?> download(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
  }) async {
    if (!await connectivity()) {
      throw const NetworkException();
    }

    try {
      return await _baseAPI.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        debugPrint('Request canceled');
        throw const RequestCanceledException();
      }
      var statusCode = e.response?.statusCode ?? 0;
      // Handle any other error types
      if (statusCode >= 500) {
        throw ServerException(e.message);
      }

      if (statusCode == 403) {
        throw const ForbiddenException();
      }

      if (statusCode == 401) {
        throw const RequestCanceledException();
      }
      rethrow;
    }
  }
}
