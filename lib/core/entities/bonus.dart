import 'package:equatable/equatable.dart';

class Bonus extends Equatable {
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
  final List<String> urls;
  final String userId;

  const Bonus({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.amount,
    required this.date,
    required this.organizationId,
    required this.creatorName,
    required this.userName,
    required this.urls,
    required this.locked,
    required this.userId,
  });

  factory Bonus.empty() {
    return Bonus(
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
      urls
    ];
  }
}
