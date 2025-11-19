import 'package:equatable/equatable.dart';

class StatusTypes extends Equatable {
  final String id;
  final String name;
  final String value;

  const StatusTypes({
    required this.id,
    required this.name,
    required this.value,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      value,
    ];
  }
}
