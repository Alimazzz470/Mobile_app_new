import '../../../core/entities/chat/chat_details.dart';
import '../../../features/chat/chat_extensions.dart';

class ChatDetailsModel extends ChatDetails {
  const ChatDetailsModel._({
    required super.id,
    required super.adminId,
    required super.userId,
    required super.adminName,
    required super.userName,
    required super.adminAvatar,
    required super.userAvatar,
    required super.type,
    required super.lastSenderId,
    required super.lastMessage,
    required super.createdAt,
    required super.updatedAt,
    required super.userUnreadCount,
    required super.adminUnreadCount,
  });

  factory ChatDetailsModel.fromJson(Map<String, dynamic> json) {
    return ChatDetailsModel._(
      id: json["id"],
      adminId: json["adminId"],
      userId: json["userId"],
      adminName: json["adminName"],
      userName: json["userName"],
      adminAvatar: json["adminAvatar"],
      userAvatar: json["userAvatar"],
      type: json["type"] != null ? getMessageType(json["type"]) : MessageType.TEXT,
      lastSenderId: json["lastSenderId"],
      lastMessage: json["lastMessage"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
      userUnreadCount: json["userUnreadCount"],
      adminUnreadCount: json["adminUnreadCount"],
    );
  }

  static ChatDetailsModel? tryParse(Map<String, dynamic> json) {
    try {
      return ChatDetailsModel.fromJson(json);
    } catch (e, _) {
      return null;
    }
  }
}
