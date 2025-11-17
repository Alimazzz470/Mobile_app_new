import '../../core/entities/salary_type.dart';

class SalaryTypeModel extends SalaryType {
  const SalaryTypeModel(
      {required super.type, required super.count, required super.amount});

  factory SalaryTypeModel.fromJson(Map<String, dynamic> json) {
    return SalaryTypeModel(
      type: json['type'],
      count: json['count'],
      amount: json['amount'],
    );
  }
}
