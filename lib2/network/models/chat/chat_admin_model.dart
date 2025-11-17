import '../../../core/entities/chat/chat_admin.dart';
import '../../../shared/helpers/app_assets.dart';

class ChatAdminModel extends ChatAdmin {
  const ChatAdminModel._({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.organizationId,
    required super.avatar,
  });

  factory ChatAdminModel.fromJson(Map<String, dynamic> json) {
    return ChatAdminModel._(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      organizationId: json["organizationId"],
      avatar: json["avatar"] ?? USER_PLACEHOLDER_IMAGE,
    );
  }
}
