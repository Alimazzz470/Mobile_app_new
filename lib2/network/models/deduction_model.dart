import '../../core/entities/deduction.dart';
import '../../shared/pagination/model.dart';

class DeductionListModel extends PaginatedResponse<DeductionModel> {
  DeductionListModel(Map<String, dynamic> json) : super(json: json);

  @override
  DeductionModel parserFunction(Map<String, dynamic> json) =>
      DeductionModel.fromJson(json);
}

class DeductionModel extends Deduction {
  const DeductionModel(
      {required super.id,
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
      required super.type,
      required super.typeId,
      required super.urls});

  factory DeductionModel.fromJson(Map<String, dynamic> json) {
    return DeductionModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date:
          json['date'] != null ? DateTime.parse(json['date']) : DateTime.now(),
      urls: json['urls'] != null
          ? (json['urls'] as List).map((e) => e.toString()).toList()
          : [],
      organizationId: json['organizationId'],
      creatorName: json['creatorName'],
      userName: json['userName'],
      locked: json['locked'],
      userId: json['userId'],
      type: json['type'],
      typeId: json['typeId'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
