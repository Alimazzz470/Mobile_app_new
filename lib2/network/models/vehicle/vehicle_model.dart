import '../../../core/entities/vehicle/vehicle.dart';
import '../../../shared/pagination/model.dart';
import '../user_model.dart';
import 'vehicle_type_model.dart';

class VehicleListModel extends PaginatedResponse<VehicleModel> {
  VehicleListModel(Map<String, dynamic> json) : super(json: json);

  @override
  VehicleModel parserFunction(Map<String, dynamic> json) =>
      VehicleModel.fromJson(json);
}

class VehicleModel extends Vehicle {
  const VehicleModel({
    required super.id,
    required super.vehicleNumber,
    required super.licenseTypeNumber,
    required super.engineType,
    required super.vehicleType,
    required super.user,
    required super.model,
    required super.brand,
    required super.color,
    required super.milage,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> data) {
    return VehicleModel(
      id: data['id'] ?? '',
      vehicleNumber: data['vehicleNumber'] ?? '',
      licenseTypeNumber: data['licenseTypeNumber'] ?? '',
      engineType: data['engineType'] ?? '',
      vehicleType: VehicleTypeModel.fromJson(data['vehicleType'] ?? {}),
      user: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      model: data['model'] ?? '',
      brand: data['brand'] ?? '',
      color: data['color'] ?? '',
      milage: data['milage'] ?? '',
    );
  }
}
