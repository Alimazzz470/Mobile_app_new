class LocalNotificationDto {
  final String id;
  final String title;
  final String message;
  final String type;

  const LocalNotificationDto({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
  });

  factory LocalNotificationDto.fromJson(Map<String, dynamic> json) =>
      LocalNotificationDto(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        message: json["message"] ?? "",
        type: json["type"] ?? "",
      );
}
