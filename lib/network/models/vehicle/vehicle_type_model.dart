import '../../../core/entities/vehicle/vehicle_type.dart';

class VehicleTypeModel extends VehicleType {
  const VehicleTypeModel({
    required super.id,
    required super.name,
  });

  factory VehicleTypeModel.fromJson(Map<String, dynamic> data) {
    return VehicleTypeModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
    );
  }
}
