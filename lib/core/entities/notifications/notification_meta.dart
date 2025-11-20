import 'package:equatable/equatable.dart';

import 'notifications_description.dart';

class NotificationMeta extends Equatable {
  final Description description;
  final Map<String, dynamic> actionData;

  const NotificationMeta({
    required this.description,
    required this.actionData,
  });

  @override
  List<Object?> get props => [description, actionData];
}
