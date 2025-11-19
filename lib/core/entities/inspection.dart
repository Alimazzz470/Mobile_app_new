import 'package:equatable/equatable.dart';

class Inspection extends Equatable {
  final String id;
  final String createdAt;
  final String? updatedAt;
  final String vehicleId;
  final String organizationId;
  final bool lastUpdated;
  final bool completed;
  final List<String>? urls;
  final String kms;
  final bool is30Days;

  const Inspection({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.vehicleId,
    required this.organizationId,
    required this.lastUpdated,
    required this.completed,
    required this.urls,
    required this.kms,
    required this.is30Days,
  });

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      updatedAt,
      vehicleId,
      organizationId,
      lastUpdated,
      completed,
      urls,
      kms,
      is30Days,
    ];
  }
}
