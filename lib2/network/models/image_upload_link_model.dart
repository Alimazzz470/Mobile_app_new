import '../../core/entities/image_upload_link.dart';

class ImageUploadLinkModel extends ImageUploadLink {
  const ImageUploadLinkModel._({
    required super.confirmationId,
    required super.uri,
    required super.carInspection,
  });

  factory ImageUploadLinkModel.fromJson(Map<String, dynamic> data) {
    return ImageUploadLinkModel._(
      confirmationId: data["confirmationId"],
      uri: data["imageUrl"] is List
          ? (data["imageUrl"] as List).map((e) => e.toString()).toList(growable: false)
          : [],
      carInspection: data['imageUrl'] is Map
          ? CarInspectionModel.fromJson(data['imageUrl'])
          : CarInspectionModel.empty(),
    );
  }
}

class CarInspectionModel extends CarInspection {
  const CarInspectionModel({
    required super.front,
    required super.back,
    required super.left,
    required super.right,
  });

  factory CarInspectionModel.fromJson(Map<String, dynamic> data) {
    return CarInspectionModel(
      front: data["front"],
      back: data["back"],
      left: data["left"],
      right: data["right"],
    );
  }

  factory CarInspectionModel.empty() {
    return const CarInspectionModel(
      front: '',
      back: '',
      left: '',
      right: '',
    );
  }
}
