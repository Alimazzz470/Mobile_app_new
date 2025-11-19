import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxiapp_mobile/core/dto/query_params.dart';
import 'package:taxiapp_mobile/core/entities/todo_tasks/todo_tasks.dart';
import 'package:taxiapp_mobile/core/exceptions/exception_model.dart';
import 'package:taxiapp_mobile/core/exceptions/null_data_exception.dart';
import 'package:taxiapp_mobile/core/exceptions/unknown_exception.dart';
import 'package:taxiapp_mobile/network/api_config.dart';
import 'package:taxiapp_mobile/network/clients/api_client.dart';
import 'package:taxiapp_mobile/network/clients/cancel_token.dart';
import 'package:taxiapp_mobile/network/models/todo_tasks/todo_task_model.dart';
import 'package:taxiapp_mobile/network/network.dart';
import 'package:taxiapp_mobile/shared/pagination/model.dart';

final todoTasksDataSourceProvider = Provider.autoDispose(
  (ref) => TodoTasksDataSource(ref.watch(apiClient)),
);

class TodoTasksDataSource {
  final ApiClient _apiClient;

  const TodoTasksDataSource(this._apiClient);

  Future<PaginatedResponse<TodoTaskModel>> getTodoTasks({
    QueryParams? params,
    CancellationToken? cancelToken,
  }) async {
    params ??= QueryParams(takeAll: true);

    try {
      var res = await _apiClient.get(
        ApiConfig.getTodoTasks(
          params: params,
        ),
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

  Future<void> changeTaskStatus({
    required String id,
    required Map<String, dynamic> body,
    CancellationToken? cancelToken,
  }) async {
    try {
      await _apiClient.patch(
          ApiConfig.changeTaskStatus(
            taskId: id,
          ),
          cancelToken: cancelToken,
          body: body);
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<TodoTasks> getSingleTask({required String taskId}) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getSingleTask(
          taskId: taskId,
        ),
      );

      if (res != null) {
        return TodoTaskModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
