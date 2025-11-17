import '../../core/entities/notifications/notification_meta.dart';
import 'notification_description_model.dart';

class NotificationMetaModel extends NotificationMeta {
  const NotificationMetaModel({
    required NotificationsDescriptionModel super.description,
    required super.actionData,
  });

  factory NotificationMetaModel.fromJson(Map<String, dynamic> data) {
    return NotificationMetaModel(
      actionData: data['actionData'] ?? {},
      description:
          NotificationsDescriptionModel.fromJson(data['description'] ?? {}),
    );
  }
}
