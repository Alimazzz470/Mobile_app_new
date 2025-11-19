import '../../core/entities/notifications/notifications.dart';
import '../../shared/pagination/model.dart';
import 'notification_meta_model.dart';

class NotificationListModel extends PaginatedResponse<NotificationsModel> {
  NotificationListModel(Map<String, dynamic> json) : super(json: json);

  @override
  NotificationsModel parserFunction(Map<String, dynamic> json) =>
      NotificationsModel.fromJson(json);
}

enum NotificationType {
  leaveCreated,
  leaveUpdated,
  leaveStatusUpdated,
  vehicleInspection,
  deductionReceived,
  advanceReceived,
  advanceUpdated,
  bonusReceived,
  newMessageReceived,
  taskCreated,
  taskUpdated,
  taskStatusUpdated
}

NotificationType parseNotificationType(String status) {
  return switch (status) {
    "LEAVE_CREATED" => NotificationType.leaveCreated,
    "LEAVE_UPDATED" => NotificationType.leaveUpdated,
    "LEAVE_STATUS_UPDATED" => NotificationType.leaveStatusUpdated,
    "DEDUCTION" => NotificationType.deductionReceived,
    "ADVANCE" => NotificationType.advanceReceived,
    "ADVANCE_STATUS_UPDATED" => NotificationType.advanceUpdated,
    "BONUS" => NotificationType.bonusReceived,
    "VEHICLE" => NotificationType.vehicleInspection,
    "NEW_MESSAGE" => NotificationType.newMessageReceived,
    "TODO_TASK_CREATED" => NotificationType.taskCreated,
    "TODO_TASK_UPDATED" => NotificationType.taskUpdated,
    "TODO_TASK_STATUS_UPDATED" => NotificationType.taskStatusUpdated,
    _ => throw Exception('Unknown notification type')
  };
}

class NotificationsModel extends Notifications {
  const NotificationsModel({
    required super.id,
    required super.meta,
    required super.createdAt,
    required super.updatedAt,
    required super.organizationId,
    required super.type,
    required super.referenceKey,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> data) {
    return NotificationsModel(
      id: data['id'] ?? '',
      meta: NotificationMetaModel.fromJson(data['meta'] ?? {}),
      createdAt: data['createdAt'] ?? '',
      updatedAt: data['updatedAt'] ?? '',
      organizationId: data['organizationId'] ?? '',
      type: data['type'] ?? '',
      referenceKey: data['referenceKey'] ?? '',
    );
  }
}
