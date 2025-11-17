import '../../core/entities/penalty.dart';
import '../../shared/pagination/model.dart';

class PenaltyListModel extends PaginatedResponse<PenaltyModal> {
  PenaltyListModel(Map<String, dynamic> json) : super(json: json);

  @override
  PenaltyModal parserFunction(Map<String, dynamic> json) =>
      PenaltyModal.fromJson(json);
}

class PenaltyModal extends Penalty {
  const PenaltyModal({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.description,
    required super.amount,
    required super.organizationId,
    required super.creatorName,
    required super.userName,
    required super.locked,
    required super.userId,
    required super.type,
    required super.typeId,
    required super.urls,
    required super.vehicleId,
    required super.subject,
    required super.referenceNumber,
    required super.paymentDate,
    required super.penaltyDate,
  });

  factory PenaltyModal.fromJson(Map<String, dynamic> json) {
    return PenaltyModal(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      description: json['description'],
      amount: (json['amount'] as num).toDouble(),
      organizationId: json['organizationId'],
      creatorName: json['creatorName'],
      userName: json['userName'],
      locked: json['locked'],
      userId: json['userId'],
      type: json['type'],
      typeId: json['typeId'],
      urls: json['urls'] != null
          ? (json['urls'] as List).map((e) => e.toString()).toList()
          : [],
      vehicleId: json['vehicleId'],
      subject: json['subject'],
      referenceNumber: json['referenceNumber'],
      paymentDate: json['paymentDate'] != null
          ? DateTime.parse(json['paymentDate'])
          : null,
      penaltyDate: DateTime.parse(json['penaltyDate']),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
}
