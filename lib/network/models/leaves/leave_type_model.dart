import '../../../core/entities/leaves/leave_type.dart';

class LeaveTypeModel extends LeaveType {
  const LeaveTypeModel._({
    required super.type,
    required super.availableDays,
    required super.appliedDays,
  });

  factory LeaveTypeModel.fromJson(Map<String, dynamic> data) {
    return LeaveTypeModel._(
      type: TypeModel.fromJson(data['leaveType']),
      availableDays: data['availableDays'],
      appliedDays: data['appliedDays'],
    );
  }
}

class TypeModel extends Type {
  const TypeModel._({
    required super.id,
    required super.name,
    required super.predefinedLeaveType,
    required super.availableDays,
  });

  factory TypeModel.fromJson(Map<String, dynamic> data) {
    return TypeModel._(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      predefinedLeaveType: data['predefinedLeaveType'],
      availableDays: data['availableDays'],
    );
  }
}
