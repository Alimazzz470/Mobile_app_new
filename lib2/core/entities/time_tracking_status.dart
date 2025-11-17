import 'package:equatable/equatable.dart';

enum TimeTrackingStatusEnum {
  running,
  breakRunning,
  breakStopped,
  stopped,
}

class TimeTrackingStatus extends Equatable {
  final bool timeTrackingRunning;
  final bool timeTrackingBreakRunning;
  final String timeTrackingBreakId;
  final String timeTrackingId;
  final bool isAvailableForTimeTracking;
  final int startKm;
  final int endKm;
  final int breaksTime;
  final int workedTime;

  const TimeTrackingStatus({
    required this.timeTrackingRunning,
    required this.timeTrackingBreakRunning,
    required this.timeTrackingBreakId,
    required this.timeTrackingId,
    required this.isAvailableForTimeTracking,
    required this.startKm,
    required this.endKm,
    required this.breaksTime,
    required this.workedTime,
  });

  const TimeTrackingStatus.empty()
      : timeTrackingRunning = false,
        timeTrackingBreakRunning = false,
        timeTrackingBreakId = '',
        timeTrackingId = '',
        isAvailableForTimeTracking = false,
        startKm = 0,
        endKm = 0,
        breaksTime = 0,
        workedTime = 0;

  @override
  List<Object?> get props => [
        timeTrackingRunning,
        timeTrackingBreakRunning,
        timeTrackingBreakId,
        timeTrackingId,
        isAvailableForTimeTracking,
        startKm,
        endKm,
        breaksTime,
        workedTime,
      ];
}
