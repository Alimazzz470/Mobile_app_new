import 'package:equatable/equatable.dart';

import '../user.dart';
import 'vehicle_type.dart';

class Vehicle extends Equatable {
  final String id;
  final String vehicleNumber;
  final String licenseTypeNumber;
  final String engineType;
  final VehicleType vehicleType;
  final User? user;
  final String model;
  final String brand;
  final String color;
  final String milage;

  const Vehicle({
    required this.id,
    required this.vehicleNumber,
    required this.licenseTypeNumber,
    required this.engineType,
    required this.vehicleType,
    required this.user,
    required this.model,
    required this.brand,
    required this.color,
    required this.milage,
  });

  @override
  List<Object?> get props => [
        id,
        vehicleNumber,
        licenseTypeNumber,
        engineType,
        vehicleType,
        user,
        model,
        brand,
        color,
        milage,
      ];
}
