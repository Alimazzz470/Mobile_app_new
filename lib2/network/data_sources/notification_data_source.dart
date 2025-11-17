import 'package:dio/dio.dart';

import '../../core/dto/query_params.dart';
import '../../core/entities/notifications/notifications.dart';
import '../../core/exceptions/exception_model.dart';
import '../../core/exceptions/null_data_exception.dart';
import '../../core/exceptions/unknown_exception.dart';
import '../../shared/pagination/model.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/notification_model.dart';

class NotificationsDataSource {
  final ApiClient _apiClient;

  const NotificationsDataSource(this._apiClient);

  Future<PaginatedResponse<Notifications>> getNotifications({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(takeAll: true);

    try {
      var res = await _apiClient.get(
        ApiConfig.getNotifications(
          params: params,
        ),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return NotificationListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> markAllAsRead({
    required DateTime dateTime,
    CancellationToken? cancelToken,
  }) async {
    try {
      await _apiClient.patch(
        ApiConfig.markAllAsRead(dateTime: dateTime),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> markAsRead({
    required String id,
    CancellationToken? cancelToken,
  }) async {
    try {
      await _apiClient.patch(
        ApiConfig.markAsRead(id: id),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
