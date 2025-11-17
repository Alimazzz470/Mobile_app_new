import '../../core/entities/notifications/notifications_description.dart';

class NotificationsDescriptionModel extends Description {
  const NotificationsDescriptionModel({
    required String text,
    required Map<String, dynamic> arguments,
  }) : super(
          text: text,
          arguments: arguments,
        );

  factory NotificationsDescriptionModel.fromJson(Map<String, dynamic> data) {
    return NotificationsDescriptionModel(
      text: data['text'] ?? '',
      arguments: data['args'] ?? {},
    );
  }
}
