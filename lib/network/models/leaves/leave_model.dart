import '../../../core/entities/leaves/leave.dart';
import '../../../shared/pagination/model.dart';
import 'leave_type_model.dart';

class LeaveListModel extends PaginatedResponse<LeaveModel> {
  LeaveListModel(Map<String, dynamic> json) : super(json: json);

  @override
  LeaveModel parserFunction(Map<String, dynamic> json) => LeaveModel.fromJson(json);
}

class LeaveModel extends Leave {
  const LeaveModel._({
    required super.id,
    required super.startDate,
    required super.endDate,
    required super.description,
    required super.approved,
    required super.rejectReason,
    required super.type,
  });

  factory LeaveModel.fromJson(Map<String, dynamic> data) {
    return LeaveModel._(
      id: data['id'] ?? '',
      startDate: data['startDate'] != null ? DateTime.parse(data['startDate']) : DateTime.now(),
      endDate: data['endDate'] != null ? DateTime.parse(data['endDate']) : null,
      description: data['description'] ?? '',
      approved: data['approved'],
      rejectReason: data['rejectReason'],
      type: TypeModel.fromJson(data['leaveType']),
    );
  }
}
