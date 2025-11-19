import 'package:equatable/equatable.dart';

class VehicleType extends Equatable {
  final String id;
  final String name;

  const VehicleType({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];
}
