import 'package:equatable/equatable.dart';

import 'notification_meta.dart';

class Notifications extends Equatable {
  final String id;
  final String createdAt;
  final String updatedAt;
  final String organizationId;
  final String type;
  final String referenceKey;
  final NotificationMeta meta;

  const Notifications({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.organizationId,
    required this.type,
    required this.meta,
    required this.referenceKey,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        meta,
        updatedAt,
        organizationId,
        type,
        referenceKey,
      ];
}
