import '../../shared/utils/date_time.dart';

class QueryParams {
  final int page;
  final int limit;
  final bool? takeAll;
  final String? order;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? leaveTypes;
  final String? startDate;
  final String? endDate;
  final String? vehicleNumber;
  final String? vehicleTypeId;
  final String? month;
  final String? year;

  QueryParams({
    this.page = 1,
    this.limit = 10,
    this.order,
    this.status,
    this.takeAll,
    this.fromDate,
    this.toDate,
    this.leaveTypes,
    this.startDate,
    this.endDate,
    this.vehicleNumber,
    this.vehicleTypeId,
    this.month,
    this.year,
  });

  factory QueryParams.empty() => QueryParams();

  Map<String, dynamic> toMap() {
    return {
      'page': page.toString(),
      'limit': limit.toString(),
      if (takeAll != null) 'takeAll': takeAll,
      if (order != null) 'order': order,
      if (status != null) 'status': status,
      if (fromDate != null) 'fromDate': parseDateToString(fromDate!),
      if (toDate != null) 'toDate': parseDateToString(toDate!),
      if (leaveTypes != null) 'leaveTypes': leaveTypes,
      if (startDate != null) 'startDate': parseDateToString(startDate!),
      if (endDate != null) 'endDate': parseDateToString(endDate!),
      if (vehicleNumber != null) 'vehicleNumber': vehicleNumber,
      if (vehicleTypeId != null) 'vehicleTypeIds': vehicleTypeId,
      if (month != null) 'month': month,
      if (year != null) 'year': year,
    };
  }
}
