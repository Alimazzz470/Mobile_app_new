import 'package:equatable/equatable.dart';

import '../../../features/leaves/leaves_extensions.dart';
import '../../../shared/utils/date_time.dart';
import 'leave_type.dart';

class Leave extends Equatable {
  final String id;
  final DateTime startDate;
  final DateTime? endDate;
  final String description;
  final bool? approved;
  final String? rejectReason;
  final Type type;

  const Leave({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.approved,
    required this.rejectReason,
    required this.type,
  });

  @override
  List<Object?> get props {
    return [
      id,
      startDate,
      endDate,
      description,
      approved,
      rejectReason,
      type,
    ];
  }

  LeaveStatus get status {
    if (approved == null) {
      return LeaveStatus.PENDING;
    } else if (approved == true) {
      return LeaveStatus.APPROVED;
    } else {
      return LeaveStatus.REJECTED;
    }
  }

  String get date {
    if (endDate == null) {
      return isSameYear(startDate, DateTime.now()) ? ddMMM(startDate) : ddMMMyyyy(startDate);
    } else {
      return isSameYear(startDate, DateTime.now())
          ? "${ddMMM(startDate)} - ${ddMMM(endDate!)}"
          : "${ddMMMyyyy(startDate)} - ${ddMMMyyyy(endDate!)}";
    }
  }
}
