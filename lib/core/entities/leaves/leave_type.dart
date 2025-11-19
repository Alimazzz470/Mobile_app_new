import 'package:equatable/equatable.dart';

class LeaveType extends Equatable {
  final Type type;
  final int? availableDays;
  final int? appliedDays;

  const LeaveType({
    required this.type,
    required this.availableDays,
    required this.appliedDays,
  });

  @override
  List<Object> get props => [type, availableDays ?? 0, appliedDays ?? 0];
}

class Type extends Equatable {
  final String id;
  final String name;
  final String? predefinedLeaveType;
  final int? availableDays;

  const Type({
    required this.id,
    required this.name,
    required this.predefinedLeaveType,
    required this.availableDays,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      predefinedLeaveType ?? '',
      availableDays ?? 0,
    ];
  }
}
