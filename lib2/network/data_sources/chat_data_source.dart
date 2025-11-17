import 'package:dio/dio.dart';
import '../../core/dto/query_params.dart';
import '../../core/entities/chat/chat_admin.dart';
import '../../core/entities/chat/chat_details.dart';
import '../../core/entities/chat/chat_message.dart';
import '../../core/exceptions/exceptions.dart';
import '../../shared/pagination/model.dart';
import '../api_config.dart';
import '../clients/api_client.dart';
import '../clients/cancel_token.dart';
import '../models/chat/chat_admin_model.dart';
import '../models/chat/chat_details_model.dart';
import '../models/chat/chat_message_model.dart';

class ChatDataSource {
  final ApiClient _apiClient;

  const ChatDataSource(this._apiClient);

  Future<List<ChatDetails>> getAllChats(CancellationToken? cancelToken) async {
    var res = await _apiClient.get(
      ApiConfig.getChats,
      cancelToken: cancelToken,
    );

    try {
      if (res != null) {
        return (res.data["data"] as List<dynamic>)
            .map((e) => ChatDetailsModel.fromJson(e))
            .toList(growable: false);
      }
      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<ChatDetails> getChatDetails(
    String chatId,
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.getChatDetails(chatId: chatId),
        cancelToken: cancelToken,
      );

      if (res != null) {
        return ChatDetailsModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<PaginatedResponse<ChatMessage>> messageList(
    String chatId,
    QueryParams? params,
    CancellationToken? cancelToken,
  ) async {
    params ??= QueryParams(
      page: params?.page ?? 1,
      limit: 10,
    );

    try {
      var res = await _apiClient.get(
        ApiConfig.getChatMessages(
          chatId: chatId,
          params: params,
        ),
        cancelToken: cancelToken,
      );
      if (res != null) {
        return ChatMessageListModel(res.data);
      }
      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<List<ChatAdmin>> getAllUsers(
      CancellationToken? cancelToken, String? name) async {
    try {
      var queryParameters = {
        if (name != null) "name": name,
      };

      var res = await _apiClient.get(ApiConfig.getUsers,
          cancelToken: cancelToken, queryParameters: queryParameters);

      if (res != null) {
        return (res.data as List<dynamic>)
            .map((e) => ChatAdminModel.fromJson(e))
            .toList(growable: false);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<int> getUnreadCount(CancellationToken? cancelToken) async {
    try {
      var res = await _apiClient.get(
        ApiConfig.unReadCount,
        cancelToken: cancelToken,
      );

      if (res != null) {
        return res.data['count'];
      }
      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }

  Future<ChatDetails> createChat(
    String adminId,
    CancellationToken? cancelToken,
  ) async {
    try {
      var res = await _apiClient.post(
        ApiConfig.createChat,
        cancelToken: cancelToken,
        body: {
          "adminId": adminId,
        },
      );

      if (res != null) {
        return ChatDetailsModel.fromJson(res.data);
      }

      throw const NullDataException();
    } on DioException catch (e) {
      var error = ExceptionModel.fromJson(e.response?.data);
      throw UnknownException(error.message);
    }
  }
}
