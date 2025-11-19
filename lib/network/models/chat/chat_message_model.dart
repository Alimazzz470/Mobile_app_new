import '../../../core/entities/chat/chat_message.dart';
import '../../../features/chat/chat_extensions.dart';
import '../../../shared/pagination/model.dart';

class ChatMessageListModel extends PaginatedResponse<ChatMessage> {
  ChatMessageListModel(Map<String, dynamic> json) : super(json: json);

  @override
  ChatMessageModel parserFunction(Map<String, dynamic> json) => ChatMessageModel.fromJson(json);
}

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel._({
    required super.id,
    required super.message,
    required super.senderId,
    required super.type,
    required super.attachmentUrls,
    required super.messageDateTime,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel._(
      id: json["id"],
      message: json["message"],
      senderId: json["senderId"],
      type: json["type"] != null ? getMessageType(json["type"]) : MessageType.TEXT,
      attachmentUrls:
          json["attachmentUrls"] != null ? List<String>.from(json["attachmentUrls"]) : [],
      messageDateTime: DateTime.parse(json["createdAt"]).toLocal(),
    );
  }

  static ChatMessageModel? tryParse(Map<String, dynamic> json) {
    try {
      return ChatMessageModel.fromJson(json);
    } catch (e, _) {
      return null;
    }
  }
}
