import 'package:dio/dio.dart';

import '../../core/dto/query_params.dart';
import '../../core/entities/time_tracking_status.dart';
import '../../core/exceptions/exception_model.dart';
import '../../core/exceptions/null_data_exception.dart';
import '../../core/exceptions/unknown_exception.dart';
import '../../shared/pagination/model.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/inspection_model.dart';
import '../models/time_tracking/driver_logs_model.dart';
import '../models/time_tracking_status_model.dart';

class TimeTrackingDataSource {
  final ApiClient _apiClient;

  const TimeTrackingDataSource(this._apiClient);

  Future<TimeTrackingStatus> getStatus() async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getTimeTrackingStatus,
      );

      if (res != null) {
        return TimeTrackingStatusModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<String> startTracking(String startKm, String startTime) async {
    try {
      var res = await _apiClient.post(
        ApiConfig.startTimeTracking,
        body: {
          'startKm': startKm,
          'startTime': startTime,
        },
      );

      if (res != null) {
        return res.data['id'];
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> stopTracking(String endKm, String endTime) async {
    try {
      var res = await _apiClient.patch(
        ApiConfig.endTimeTracking,
        body: {
          'endKm': endKm,
          'endTime': endTime,
        },
      );

      if (res != null) {
        return;
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> startBreak(String startTime) async {
    try {
      var res = await _apiClient.patch(
        ApiConfig.startBreak,
        body: {
          'breakTime': startTime,
        },
      );

      if (res != null) {
        return;
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> stopBreak(String endTime) async {
    try {
      var res = await _apiClient.patch(
        ApiConfig.endBreak,
        body: {
          'breakTime': endTime,
        },
      );

      if (res != null) {
        return;
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<PaginatedResponse<DriverLogsModel>> getDriverLogs({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getDriverLogs(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return DriverLogListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<void> downloadLogs({
    required String downloadPath,
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams();

    try {
      await _apiClient.download(
        ApiConfig.downloadLogs(params: params),
        downloadPath,
      );
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<InspectionModel> getInspectionAvailability(
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.inspectionAvailability,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return InspectionModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<bool> timeTrackingSignature(
    String timeTrackingId,
    String confirmationId,
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.patch(
        ApiConfig.timeTrackingSignature(timeTrackingId),
        body: {
          'confirmationId': confirmationId,
        },
        cancelToken: cancelToken,
      );

      if (res != null) {
        return true;
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
