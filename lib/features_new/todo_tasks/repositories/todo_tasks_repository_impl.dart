import 'package:taxiapp_mobile/core/dto/query_params.dart';
import 'package:taxiapp_mobile/core/entities/todo_tasks/todo_tasks.dart';
import 'package:taxiapp_mobile/core/exceptions/coded_exception.dart';
import 'package:taxiapp_mobile/core/exceptions/request_canceled_exception.dart';
import 'package:taxiapp_mobile/core/exceptions/unknown_exception.dart';
import 'package:taxiapp_mobile/features/todo_tasks/repositories/todo_tasks_repository.dart';
import 'package:taxiapp_mobile/network/clients/cancel_token.dart';
import 'package:taxiapp_mobile/network/data_sources/todo_tasks_data_source.dart';
import 'package:taxiapp_mobile/shared/pagination/model.dart';
import 'package:taxiapp_mobile/shared/utils/result.dart';

class TodoTasksRepositoryImpl extends TodoTasksRepository {
  final TodoTasksDataSource _dataSource;

  TodoTasksRepositoryImpl({
    required TodoTasksDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  FutureResult<PaginatedResponse<TodoTasks>> getTodoTasks(
      {QueryParams? params, CancellationToken? cancelToken}) async {
    try {
      final result = await _dataSource.getTodoTasks(
        params: params,
        cancelToken: cancelToken,
      );
      return Success(result);
    } on RequestCanceledException {
      return const Canceled();
    } catch (e, stackTrace) {
      if (e is CodedException) {
        return Failure(e, stackTrace);
      }
      return Failure(UnknownException(e.toString()), stackTrace);
    }
  }

  @override
  FutureResult<void> changeTaskStatus(
      {required String id,
      required Map<String, dynamic> body,
      CancellationToken? cancelToken}) async {
    try {
      return Success(_dataSource.changeTaskStatus(
        id: id,
        body: body,
        cancelToken: cancelToken,
      ));
    } on RequestCanceledException {
      return const Canceled();
    } catch (e, stackTrace) {
      if (e is CodedException) {
        return Failure(e, stackTrace);
      }
      return Failure(UnknownException(e.toString()), stackTrace);
    }
  }

  @override
  FutureResult<TodoTasks> getSingleTask({required String taskId}) async {
    try {
      return Success(await _dataSource.getSingleTask(taskId: taskId));
    } on RequestCanceledException {
      return const Canceled();
    } catch (e, stackTrace) {
      if (e is CodedException) {
        return Failure(e, stackTrace);
      }
      return Failure(UnknownException(e.toString()), stackTrace);
    }
  }
}
