enum ToastType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

enum UploadImageType {
  CAR_INSPECTION,
  CHAT,
  SIGNATURE,
}

extension UploadImageTypeDBExtension on UploadImageType {
  String get dbValue {
    switch (this) {
      case UploadImageType.CAR_INSPECTION:
        return "CAR_INSPECTION";
      case UploadImageType.CHAT:
        return "CHAT";
      case UploadImageType.SIGNATURE:
        return "SIGNATURE";
    }
  }
}
