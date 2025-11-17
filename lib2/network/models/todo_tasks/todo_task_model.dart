import 'package:taxiapp_mobile/core/entities/todo_tasks/todo_tasks.dart';
import 'package:taxiapp_mobile/shared/pagination/model.dart';

class LeaveListModel extends PaginatedResponse<TodoTaskModel> {
  LeaveListModel(Map<String, dynamic> json) : super(json: json);

  @override
  TodoTaskModel parserFunction(Map<String, dynamic> json) =>
      TodoTaskModel.fromJson(json);
}

class TodoTaskModel extends TodoTasks {
  const TodoTaskModel({
    required String id,
    required String title,
    required String description,
    required List<String> urls,
    required String userId,
    required String priority,
    required List<String> departments,
    required List<TaskUserStatus> taskUserStatus,
    required String status,
    required String createdAt,
  }) : super(
          id: id,
          title: title,
          description: description,
          urls: urls,
          userId: userId,
          priority: priority,
          taskUserStatus: taskUserStatus,
          departments: departments,
          status: status,
          createdAt: createdAt,
        );

  factory TodoTaskModel.fromJson(Map<String, dynamic> data) {
    return TodoTaskModel(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      urls: (data['urls'] as List)
          .map((e) => e.toString())
          .toList(growable: false),
      userId: data['userId'] ?? '',
      priority: data['priority'] ?? '',
      departments: (data['departments'] as List)
          .map((e) => e.toString())
          .toList(growable: false),
      taskUserStatus: (data['taskUserStatus'] as List)
          .map((e) => TaskUserStatusModel.fromJson(e))
          .toList(growable: false),
      status: data['status'] ?? '',
      createdAt: data['createdAt'] ?? '',
    );
  }
}

class TaskUserStatusModel extends TaskUserStatus {
  const TaskUserStatusModel({
    required TaskUser taskUser,
    required String status,
  }) : super(
          taskUser: taskUser,
          status: status,
        );

  factory TaskUserStatusModel.fromJson(Map<String, dynamic> data) {
    return TaskUserStatusModel(
      taskUser: TaskUserModel.fromJson(data['user']),
      status: data['status'] ?? '',
    );
  }
}

class TaskUserModel extends TaskUser {
  const TaskUserModel({
    required String userId,
    required String createdAt,
    required String updatedAt,
  }) : super(
          userId: userId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory TaskUserModel.fromJson(Map<String, dynamic> data) {
    return TaskUserModel(
      userId: data['id'] ?? '',
      createdAt: data['createdAt'] ?? '',
      updatedAt: data['updatedAt'] ?? '',
    );
  }
}
