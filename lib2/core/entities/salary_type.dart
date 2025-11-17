import 'package:equatable/equatable.dart';

import '../../router/routes.dart';

class SalaryType extends Equatable {
  final String type;
  final int count;
  final int amount;

  const SalaryType({
    required this.type,
    required this.count,
    required this.amount,
  });

  String get route {
    return switch (type) {
      'advance' => Routes.advance,
      'deduction' => Routes.deduction,
      'bonus' => Routes.bonus,
      'penalty' => Routes.penalty,
      _ => '',
    };
  }

  @override
  List<Object> get props => [type, count];
}
