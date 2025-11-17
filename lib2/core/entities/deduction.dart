import 'package:equatable/equatable.dart';

class Deduction extends Equatable {
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
  final String userId;
  final List<String> urls;
  final String type;
  final String typeId;

  const Deduction({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.amount,
    required this.date,
    required this.organizationId,
    required this.creatorName,
    required this.userName,
    required this.locked,
    required this.userId,
    required this.urls,
    required this.type,
    required this.typeId,
  });

  factory Deduction.empty() {
    return Deduction(
      id: '',
      createdAt: DateTime.now(),
      updatedAt: null,
      description: '',
      amount: 0,
      date: DateTime.now(),
      organizationId: '',
      creatorName: '',
      userName: '',
      locked: false,
      userId: '',
      type: '',
      typeId: '',
      urls: const [],
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
      date,
      organizationId,
      creatorName,
      userName,
      locked,
      userId,
      type,
      typeId,
      urls
    ];
  }
}
