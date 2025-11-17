import 'package:equatable/equatable.dart';

import '../../features/profile/profile_extensions.dart';

class ImageUploadLink extends Equatable {
  final String confirmationId;
  final List<String> uri;
  final CarInspection carInspection;

  const ImageUploadLink({
    required this.confirmationId,
    required this.uri,
    required this.carInspection,
  });

  @override
  List<Object?> get props => [confirmationId, uri, carInspection];
}

class CarInspection extends Equatable {
  final String front;
  final String back;
  final String left;
  final String right;

  const CarInspection({
    required this.front,
    required this.back,
    required this.left,
    required this.right,
  });

  String operator [](VehicleInspectionType type) {
    switch (type) {
      case VehicleInspectionType.FRONT:
        return front;
      case VehicleInspectionType.BACK:
        return back;
      case VehicleInspectionType.LEFT:
        return left;
      case VehicleInspectionType.RIGHT:
        return right;
    }
  }

  @override
  List<Object> get props => [front, back, left, right];
}
