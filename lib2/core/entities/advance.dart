// ignore_for_file: unnecessary_this

import 'package:equatable/equatable.dart';
import 'package:taxiapp_mobile/features/profile/profile_extensions.dart';

class Advance extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String description;
  final double amount;
  final DateTime date;
  final String organizationId;
  final String creatorName;
  final String userName;
  final bool locked;
  final String installmentPeriod;
  final List<String> urls;
  final String completedInstallmentPeriod;
  final String userId;
  final bool? approved;
  final String? rejectReason;

  const Advance({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.description,
    required this.amount,
    required this.date,
    required this.organizationId,
    required this.creatorName,
    required this.userName,
    required this.locked,
    required this.installmentPeriod,
    required this.urls,
    required this.completedInstallmentPeriod,
    required this.userId,
    this.approved,
    this.rejectReason,
  });

  factory Advance.empty() {
    return Advance(
      id: '',
      createdAt: DateTime.now(),
      description: '',
      amount: 0,
      date: DateTime.now(),
      organizationId: '',
      creatorName: '',
      userName: '',
      locked: false,
      installmentPeriod: '',
      completedInstallmentPeriod: '',
      userId: '',
      urls: const [],
    );
  }

  AdvanceStatus get status {
    if (approved == null) {
      return AdvanceStatus.PENDING;
    } else if (approved == true) {
      return AdvanceStatus.APPROVED;
    } else {
      return AdvanceStatus.REJECTED;
    }
  }

  @override
  List<Object?> get props {
    return [
      id,
      createdAt,
      updatedAt,
      description,
      amount,
      date,
      organizationId,
      creatorName,
      userName,
      locked,
      installmentPeriod,
      completedInstallmentPeriod,
      userId,
      approved,
      rejectReason,
      urls
    ];
  }
}
