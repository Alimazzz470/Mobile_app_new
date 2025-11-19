import 'package:equatable/equatable.dart';

class DriverLog extends Equatable {
  final String id;
  final String endKm;
  final String startKm;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<Break> breaks;
  final String breaksTime;
  final String workedTime;

  const DriverLog({
    required this.id,
    required this.endKm,
    required this.startKm,
    required this.startTime,
    required this.endTime,
    required this.breaks,
    required this.breaksTime,
    required this.workedTime,
  });

  const DriverLog.empty()
      : id = '',
        endKm = '',
        startKm = '',
        startTime = null,
        endTime = null,
        breaks = const [],
        breaksTime = '',
        workedTime = '';

  @override
  List<Object> get props {
    return [
      id,
      endKm,
      startKm,
      startTime ?? '',
      endTime ?? '',
      breaks,
      breaksTime,
      workedTime,
    ];
  }
}

class Break extends Equatable {
  final String id;
  final DateTime? breakEnded;
  final DateTime? breakStarted;

  const Break({
    required this.id,
    required this.breakEnded,
    required this.breakStarted,
  });

  const Break.empty()
      : id = '',
        breakEnded = null,
        breakStarted = null;

  @override
  List<Object> get props {
    return [
      id,
      breakEnded ?? '',
      breakStarted ?? '',
    ];
  }
}
