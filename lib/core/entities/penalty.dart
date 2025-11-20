import 'package:equatable/equatable.dart';

class Penalty extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String description;
  final double amount;
  final String organizationId;
  final String creatorName;
  final String userName;
  final bool locked;
  final String userId;
  final String type;
  final String typeId;
  final List<String> urls;
  final String? vehicleId;
  final String subject;
  final String? referenceNumber;
  final DateTime? paymentDate;
  final DateTime penaltyDate;

  const Penalty({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.amount,
    required this.organizationId,
    required this.creatorName,
    required this.userName,
    required this.locked,
    required this.userId,
    required this.type,
    required this.typeId,
    required this.urls,
    required this.vehicleId,
    required this.subject,
    required this.referenceNumber,
    required this.paymentDate,
    required this.penaltyDate,
  });

  factory Penalty.empty() {
    return Penalty(
      id: '',
      createdAt: DateTime.now(),
      updatedAt: null,
      description: '',
      amount: 0,
      organizationId: '',
      creatorName: '',
      userName: '',
      locked: false,
      userId: '',
      type: '',
      typeId: '',
      urls: const [],
      vehicleId: '',
      subject: '',
      referenceNumber: '',
      paymentDate: null,
      penaltyDate: DateTime.now(),
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      updatedAt,
      description,
      amount,
      organizationId,
      creatorName,
      userName,
      locked,
      userId,
      type,
      typeId,
      urls,
      vehicleId,
      subject,
      referenceNumber,
      paymentDate,
      penaltyDate,
    ];
  }
}
