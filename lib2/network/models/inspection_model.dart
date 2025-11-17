import '../../core/entities/inspection.dart';

class InspectionModel extends Inspection {
  const InspectionModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.vehicleId,
    required super.organizationId,
    required super.lastUpdated,
    required super.completed,
    required super.urls,
    required super.kms,
    required super.is30Days,
  });

  factory InspectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionModel(
      id: json['id'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String?,
      vehicleId: json['vehicleId'] as String,
      organizationId: json['organizationId'] as String,
      lastUpdated: json['lastUpdated'] as bool,
      completed: json['completed'] as bool,
      urls: json['urls'] != null ? (json['urls'] as List).map((e) => e as String).toList() : null,
      kms: json['kms'] as String,
      is30Days: json['is30Days'] as bool,
    );
  }
}
