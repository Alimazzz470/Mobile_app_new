import 'package:dio/dio.dart';

import '../../core/dto/query_params.dart';
import '../../core/entities/leaves/leave_type.dart';
import '../../core/exceptions/exceptions.dart';
import '../../shared/pagination/model.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/leaves/leave_model.dart';
import '../models/leaves/leave_type_model.dart';

class LeavesDataSource {
  final ApiClient _apiClient;

  const LeavesDataSource(this._apiClient);

  Future<void> requestLeave({
    required String type,
    required String reason,
    required String startDate,
    required String endDate,
    CancellationToken? cancelToken,
  }) async {
    try {
      var res = await _apiClient.post(
        ApiConfig.createLeave,
        body: {
          'leaveType': type,
          'description': reason,
          'startDate': startDate,
          'endDate': endDate,
        },
        cancelToken: cancelToken,
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

  Future<List<LeaveType>> getLeaveTypes({
    CancellationToken? cancelToken,
  }) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getLeaveTypes,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return (res.data as List).map((e) => LeaveTypeModel.fromJson(e)).toList(growable: false);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<PaginatedResponse<LeaveModel>> getLeaves({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getLeaves(params: params),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return LeaveListModel(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
