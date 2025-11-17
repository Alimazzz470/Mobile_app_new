import '../../core/entities/time_tracking_status.dart';

class TimeTrackingStatusModel extends TimeTrackingStatus {
  const TimeTrackingStatusModel({
    required bool timeTrackingRunning,
    required bool timeTrackingBreakRunning,
    required String timeTrackingBreakId,
    required String timeTrackingId,
    required bool isAvailableForTimeTracking,
    required int startKm,
    required int endKm,
    required int breaksTime,
    required int workedTime,
  }) : super(
          timeTrackingRunning: timeTrackingRunning,
          timeTrackingBreakRunning: timeTrackingBreakRunning,
          timeTrackingBreakId: timeTrackingBreakId,
          timeTrackingId: timeTrackingId,
          isAvailableForTimeTracking: isAvailableForTimeTracking,
          startKm: startKm,
          endKm: endKm,
          breaksTime: breaksTime,
          workedTime: workedTime,
        );

  factory TimeTrackingStatusModel.fromJson(Map<String, dynamic> data) {
    return TimeTrackingStatusModel(
      timeTrackingRunning: data['timeTrackingRunning'] ?? false,
      timeTrackingBreakRunning: data['timeTrackingBreakRunning'] ?? false,
      timeTrackingBreakId: data['timeTrackingBreakId'] ?? '',
      timeTrackingId: data['timeTrackingId'] ?? '',
      isAvailableForTimeTracking: data['isAvailableForTimeTracking'] ?? false,
      startKm: data['startKm'] ?? 0,
      endKm: data['endKm'] ?? 0,
      breaksTime: data['breaksTime'] ?? 0,
      workedTime: data['workedTime'] ?? 0,
    );
  }
}
