import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxiapp_mobile/core/dto/query_params.dart';
import 'package:taxiapp_mobile/core/entities/todo_tasks/todo_tasks.dart';
import 'package:taxiapp_mobile/core/exceptions/request_canceled_exception.dart';
import 'package:taxiapp_mobile/features/todo_tasks/repositories/todo_tasks_repository.dart';
import 'package:taxiapp_mobile/network/clients/cancel_token.dart';
import 'package:taxiapp_mobile/network/models/common/status_type_model.dart';
import 'package:taxiapp_mobile/shared/helpers/app_data.dart';
import 'package:taxiapp_mobile/shared/pagination/model.dart';
import 'package:taxiapp_mobile/shared/providers/common_providers.dart';
import 'package:taxiapp_mobile/shared/utils/result.dart';
import 'package:taxiapp_mobile/shared/utils/typedef.dart';

final todoTasksProvider = AsyncNotifierProvider.autoDispose<TodoTasksProvider,
    ResponseDTO<TodoTasks>>(TodoTasksProvider.new);

final changeStatusProvider = NotifierProvider.family
    .autoDispose<ChangeStatusNotifier, StatusTypes, String>(
        (ChangeStatusNotifier.new));

class ChangeStatusNotifier
    extends AutoDisposeFamilyNotifier<StatusTypes, String> {
  @override
  build(String arg) {
    return statusTypes.firstWhere((element) => element.value == arg,
        orElse: () => statusTypes.first);
  }

  void updateStatus(String status) {
    state = statusTypes.firstWhere((element) => element.value == status,
        orElse: () => statusTypes.first);
  }
}

final getSingleTaskProvider = AsyncNotifierFamilyProvider.autoDispose<
    GetTodoTaskNotifier, TodoTasks, String>(GetTodoTaskNotifier.new);

class GetTodoTaskNotifier
    extends AutoDisposeFamilyAsyncNotifier<TodoTasks, String> {
  @override
  FutureOr<TodoTasks> build(String arg) {
    return _build(arg);
  }

  Future<TodoTasks> _build(String taskId) async {
    final todoTasksRepository = ref.read(todoTasksRepositoryProvider);
    final res = await todoTasksRepository.getSingleTask(taskId: taskId);
    switch (res) {
      case Success s:
        var value = s.value as TodoTasks;
        state = AsyncData(value);
        return value;
      case Failure e:
        state = AsyncError(e.exception, e.stackTrace);
        return Future.error(e.exception, e.stackTrace);
      case Canceled _:
        return TodoTasks.empty();
    }
  }
}

class TodoTasksProvider
    extends AutoDisposeAsyncNotifier<ResponseDTO<TodoTasks>> {
  int _page = 1;
  bool _hasNextPage = true;
  late final Set<TodoTasks> _data = {};

  final List<CancellationToken> _tokens = [];

  @override
  FutureOr<ResponseDTO<TodoTasks>> build() async {
    ref.onRemoveListener(_cancelPendingTasks);

    // final filters = ref.watch(leaveFilterProvider);
    // _filterDto = filters;
    _page = 1;
    _hasNextPage = true;
    _data.clear();
    _cancelPendingTasks();

    return _load();
  }

  Future<void> loadMore() async {
    await _load();
  }

  Future<ResponseDTO<TodoTasks>> _load() async {
    var _cancelToken = CancellationToken();

    final todoTasksRepository = ref.read(todoTasksRepositoryProvider);

    if (!_hasNextPage) {
      return state.asData?.value ?? ResponseDTO.empty();
    }

    var props = QueryParams(
      page: _page,
    );

    _tokens.add(_cancelToken);
    var res = await todoTasksRepository.getTodoTasks(
      params: props,
      cancelToken: _tokens.last,
    );
    _tokens.remove(_cancelToken);

    switch (res) {
      case Success s:
        var value = s.value as PaginatedResponse<TodoTasks>;
        _hasNextPage = !value.isLastPage;
        if (_hasNextPage) {
          _page++;
        }
        _data.addAll(value.data);
        var dto = ResponseDTO(
          data: _data.toList(growable: false),
          hasNextPage: _hasNextPage,
          totalPages: value.pageCount,
        );
        state = AsyncData(dto);
        return dto;
      case Failure e:
        state = AsyncError(e.exception, e.stackTrace);
        return Future.error(e.exception, e.stackTrace);
      case Canceled _:
        return ResponseDTO.empty();
    }
  }

  void changeTaskStatus({
    required String taskId,
    required String status,
    required OnSuccessVoidCallback onSuccess,
  }) async {
    var body = {
      'status': status,
    };

    state = const AsyncLoading();

    final todoTasksRepository = ref.read(todoTasksRepositoryProvider);

    var _cancelToken = CancellationToken();

    _tokens.add(_cancelToken);

    var res = await todoTasksRepository.changeTaskStatus(
      id: taskId,
      body: body,
      cancelToken: _tokens.last,
    );

    switch (res) {
      case Success s:
        onSuccess();
        state = AsyncData(ResponseDTO.empty());
        return;
      case Failure e:
        state = AsyncError(e.exception, e.stackTrace);
        return;
      case Canceled _:
        return;
    }
  }

  void _cancelPendingTasks() {
    for (var token in _tokens) {
      token.cancel();
    }
    _tokens.clear();
  }
}
