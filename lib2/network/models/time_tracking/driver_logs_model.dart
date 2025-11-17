import '../../../core/entities/time_tracking/driver_logs.dart';
import '../../../shared/pagination/model.dart';

class DriverLogListModel extends PaginatedResponse<DriverLogsModel> {
  DriverLogListModel(Map<String, dynamic> json) : super(json: json);

  @override
  DriverLogsModel parserFunction(Map<String, dynamic> json) => DriverLogsModel.fromJson(json);
}

class DriverLogsModel extends DriverLog {
  const DriverLogsModel({
    required super.id,
    required super.endKm,
    required super.startKm,
    required super.startTime,
    required super.endTime,
    required super.breaks,
    required super.breaksTime,
    required super.workedTime,
  });

  factory DriverLogsModel.fromJson(Map<String, dynamic> data) {
    return DriverLogsModel(
      id: data['id'],
      endKm: data['endKm'] ?? 0,
      startKm: data['startKm'] ?? 0,
      startTime: data['startTime'] != null ? DateTime.parse(data['startTime']).toLocal() : null,
      endTime: data['endTime'] != null ? DateTime.parse(data['endTime']).toLocal() : null,
      breaks: (data['breaks'] as List).map((e) => BreakModel.fromJson(e)).toList(growable: false),
      breaksTime: data['breaksTime'] ?? "00h 00m",
      workedTime: data['workedTime'] ?? "00h 00m",
    );
  }
}

class BreakModel extends Break {
  const BreakModel({
    required super.id,
    required super.breakEnded,
    required super.breakStarted,
  });

  factory BreakModel.fromJson(Map<String, dynamic> data) {
    return BreakModel(
      id: data['id'],
      breakEnded: data['breakEnded'] != null ? DateTime.parse(data['breakEnded']).toLocal() : null,
      breakStarted:
          data['breakStarted'] != null ? DateTime.parse(data['breakStarted']).toLocal() : null,
    );
  }
}
