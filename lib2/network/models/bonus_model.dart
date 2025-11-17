import '../../core/entities/bonus.dart';
import '../../shared/pagination/model.dart';

class BonusListModel extends PaginatedResponse<BonusModel> {
  BonusListModel(Map<String, dynamic> json) : super(json: json);

  @override
  BonusModel parserFunction(Map<String, dynamic> json) =>
      BonusModel.fromJson(json);
}

class BonusModel extends Bonus {
  const BonusModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.description,
    required super.amount,
    required super.date,
    required super.organizationId,
    required super.creatorName,
    required super.userName,
    required super.locked,
    required super.userId,
    required super.urls,
  });

  factory BonusModel.fromJson(Map<String, dynamic> json) {
    return BonusModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      urls: json['urls'] != null
          ? (json['urls'] as List).map((e) => e.toString()).toList()
          : [],
      date: DateTime.parse(json['date']),
      organizationId: json['organizationId'],
      creatorName: json['creatorName'],
      userName: json['userName'],
      locked: json['locked'],
      userId: json['userId'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
