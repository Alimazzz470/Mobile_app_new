import 'package:equatable/equatable.dart';

import '../../../features/chat/chat_extensions.dart';

class ChatMessage extends Equatable {
  final String id;
  final String message;
  final String senderId;
  final MessageType type;
  final List<String> attachmentUrls;
  final DateTime messageDateTime;
  final bool isLoading;
  final int fileSize;

  const ChatMessage({
    required this.id,
    required this.message,
    required this.senderId,
    required this.type,
    required this.attachmentUrls,
    required this.messageDateTime,
    this.isLoading = false,
    this.fileSize = 0,
  });

  ChatMessage copyWith({
    bool? isLoading,
    int? fileSize,
  }) {
    return ChatMessage(
      id: id,
      message: message,
      senderId: senderId,
      type: type,
      attachmentUrls: attachmentUrls,
      messageDateTime: messageDateTime,
      isLoading: isLoading ?? this.isLoading,
      fileSize: fileSize ?? this.fileSize,
    );
  }

  @override
  List<Object?> get props =>
      [id, message, senderId, type, attachmentUrls, messageDateTime, isLoading, fileSize];
}
