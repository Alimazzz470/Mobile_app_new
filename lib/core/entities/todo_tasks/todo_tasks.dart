import 'package:equatable/equatable.dart';

class TodoTasks extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> urls;
  final List<String> departments;
  final List<TaskUserStatus> taskUserStatus;
  final String userId;
  final String status;
  final String priority;
  final String createdAt;

  const TodoTasks({
    required this.id,
    required this.title,
    required this.description,
    required this.taskUserStatus,
    required this.urls,
    required this.userId,
    required this.priority,
    required this.departments,
    required this.status,
    required this.createdAt,
  });

  // create empty TodoTasks
  static TodoTasks empty() {
    return const TodoTasks(
      id: '',
      title: '',
      description: '',
      taskUserStatus: [],
      urls: [],
      userId: '',
      priority: '',
      departments: [],
      status: '',
      createdAt: '',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      urls,
      userId,
      departments,
      priority,
      description,
      status,
      createdAt,
    ];
  }
}

class TaskUserStatus extends Equatable {
  final TaskUser taskUser;
  final String status;

  const TaskUserStatus({
    required this.taskUser,
    required this.status,
  });

  @override
  List<Object> get props {
    return [
      taskUser,
      status,
    ];
  }
}

class TaskUser extends Equatable {
  final String userId;
  final String createdAt;
  final String updatedAt;

  const TaskUser({
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props {
    return [
      userId,
      createdAt,
      updatedAt,
    ];
  }
}
