import 'package:equatable/equatable.dart';

import '../../../features/chat/chat_extensions.dart';
import '../../../shared/utils/date_time.dart';
import 'chat_message.dart';

class ChatDetails extends Equatable {
  final String id;
  final String adminId;
  final String userId;
  final String adminName;
  final String userName;
  final String? adminAvatar;
  final String? userAvatar;
  final MessageType type;
  final String? lastSenderId;
  final String? lastMessage;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int userUnreadCount;
  final int adminUnreadCount;

  const ChatDetails({
    required this.id,
    required this.adminId,
    required this.userId,
    required this.adminName,
    required this.userName,
    required this.adminAvatar,
    required this.userAvatar,
    required this.type,
    required this.lastSenderId,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.userUnreadCount,
    required this.adminUnreadCount,
  });

  ChatDetails replaceLastMessage(ChatMessage lastMessage) {
    return ChatDetails(
      id: id,
      adminId: adminId,
      userId: userId,
      adminName: adminName,
      userName: userName,
      adminAvatar: adminAvatar,
      userAvatar: userAvatar,
      type: lastMessage.type,
      lastSenderId: lastMessage.senderId,
      lastMessage: lastMessage.message,
      createdAt: lastMessage.messageDateTime,
      updatedAt: updatedAt,
      userUnreadCount: userUnreadCount,
      adminUnreadCount: adminUnreadCount,
    );
  }

  ChatDetails replaceUnreadCount({
    required int? userUnreadCount,
    required int? adminUnreadCount,
  }) {
    return ChatDetails(
      id: id,
      adminId: adminId,
      userId: userId,
      adminName: adminName,
      userName: userName,
      adminAvatar: adminAvatar,
      userAvatar: userAvatar,
      type: type,
      lastSenderId: lastSenderId,
      lastMessage: lastMessage,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userUnreadCount: userUnreadCount ?? this.userUnreadCount,
      adminUnreadCount: adminUnreadCount ?? this.adminUnreadCount,
    );
  }

  ChatDetails replaceChatTime(DateTime updatedAt) {
    return ChatDetails(
      id: id,
      adminId: adminId,
      userId: userId,
      adminName: adminName,
      userName: userName,
      adminAvatar: adminAvatar,
      userAvatar: userAvatar,
      type: type,
      lastSenderId: lastSenderId,
      lastMessage: lastMessage,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userUnreadCount: userUnreadCount,
      adminUnreadCount: adminUnreadCount,
    );
  }

  String get time => updatedAt != null
      ? formatTimeInChatlist(updatedAt!)
      : formatTimeInChatlist(createdAt);

  @override
  List<Object> get props {
    return [
      id,
      adminId,
      userId,
      type,
      lastSenderId ?? "",
      lastMessage ?? "",
    ];
  }
}
