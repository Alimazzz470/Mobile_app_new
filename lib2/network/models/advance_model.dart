import '../../core/entities/advance.dart';
import '../../shared/pagination/model.dart';

class AdvanceListModel extends PaginatedResponse<AdvanceModel> {
  AdvanceListModel(Map<String, dynamic> json) : super(json: json);

  @override
  AdvanceModel parserFunction(Map<String, dynamic> json) =>
      AdvanceModel.fromJson(json);
}

class AdvanceModel extends Advance {
  const AdvanceModel(
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
      required super.installmentPeriod,
      required super.completedInstallmentPeriod,
      required super.userId,
      required super.approved,
      required super.rejectReason,
      required super.urls});

  factory AdvanceModel.fromJson(Map<String, dynamic> json) {
    return AdvanceModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      organizationId: json['organizationId'],
      creatorName: json['creatorName'],
      userName: json['userName'],
      locked: json['locked'],
      installmentPeriod: json['installmentPeriod'],
      urls: json['urls'] != null
          ? (json['urls'] as List).map((e) => e.toString()).toList()
          : [],
      completedInstallmentPeriod: json['completedInstallmentPeriod'],
      userId: json['userId'],
      approved: json['approved'],
      rejectReason: json['rejectReason'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
