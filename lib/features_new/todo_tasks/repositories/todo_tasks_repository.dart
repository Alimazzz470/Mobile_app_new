import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxiapp_mobile/core/dto/query_params.dart';
import 'package:taxiapp_mobile/core/entities/todo_tasks/todo_tasks.dart';
import 'package:taxiapp_mobile/features/todo_tasks/repositories/todo_tasks_repository_impl.dart';
import 'package:taxiapp_mobile/network/clients/cancel_token.dart';
import 'package:taxiapp_mobile/network/data_sources/todo_tasks_data_source.dart';
import 'package:taxiapp_mobile/shared/pagination/model.dart';
import 'package:taxiapp_mobile/shared/utils/result.dart';

final todoTasksRepositoryProvider = Provider.autoDispose<TodoTasksRepository>(
  (ref) => TodoTasksRepositoryImpl(
    // connectivity: ref.watch(connectivityProvider),
    dataSource: ref.watch(todoTasksDataSourceProvider),
  ),
);

abstract class TodoTasksRepository {
  FutureResult<PaginatedResponse<TodoTasks>> getTodoTasks({
    QueryParams? params,
    CancellationToken? cancelToken,
  });

  FutureResult<TodoTasks> getSingleTask({required String taskId});

  FutureResult<void> changeTaskStatus({
    required String id,
    required Map<String, dynamic> body,
    CancellationToken? cancelToken,
  });
}
