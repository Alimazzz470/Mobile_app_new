import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:socket_io_client/socket_io_client.dart';

import '../../features/chat/providers/chat_provider.dart';
import '../../features/chat/providers/messages_provider.dart';
import '../../network/api_config.dart';
import '../../network/models/chat/chat_details_model.dart';
import '../../network/models/chat/chat_message_model.dart';
import '../../network/network.dart';

final webSocketProvider = Provider.autoDispose<WebSocketProvider>((ref) {
  final val = _SocketIOProviderImpl(ref);
  ref.onDispose(val.closeConnection);

  return val;
});

abstract class WebSocketProvider {
  Future<void> connect();
  Future<void> closeConnection();
  void emit(String action, dynamic message);
}

class _SocketIOProviderImpl implements WebSocketProvider {
  io.Socket? _socket;

  final Ref ref;
  _SocketIOProviderImpl(this.ref) {
    connect();
  }

  @override
  Future<void> connect() async {
    try {
      var token = await _getAccessToken();
      // This checks if user had signed in, or trying to subscribe twice
      if (token == null || _socket?.connected == true) return;

      // TODO: Remove when dev is done
      final _baseUrl =
          Platform.isAndroid ? 'http://10.0.2.2:4000' : 'http://localhost:4000';

      _socket ??= io.io(
        SOCKET_URL,
        // _baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'token': token})
            .build(),
      );

      _socket?.connect();
      _socket?.onConnect((_) => log('Web Socket: Connected'));
      _socket?.onDisconnect((_) => log('Web Socket: Disconnected'));
      _socket?.onConnectError((err) => log('Web Socket: $err'));
      _socket?.onError((err) => log("Web Socket: $err"));

      _registerListeners();
    } catch (e, _) {
      debugPrint(e.toString());
    }
  }

  Future<String?> _getAccessToken() async {
    try {
      var token = await ref.read(tokenDataSource).get();
      return token.accessToken;
    } catch (_) {
      return null;
    }
  }

  void _registerListeners() {
    _socket?.on('message', (data) {
      var chatId = data["chatId"] ?? "";
      var message = ChatMessageModel.tryParse(data);

      if (ref.exists(chatMessagesProvider(chatId))) {
        ref
            .read(chatMessagesProvider(chatId).notifier)
            .tryUpdateMessage(message);
      }

      if (ref.exists(chatListProvider)) {
        ref
            .read(chatListProvider.notifier)
            .tryUpdateLastMessage(chatId, message);
      }
    });

    _socket?.on('chat', (data) {
      var chat = ChatDetailsModel.tryParse(data);

      ref.invalidate(unreadCountProvider);

      if (ref.exists(chatListProvider)) {
        ref.read(chatListProvider.notifier).upateChatDetails(chat);
      }
    });
  }

  @override
  void emit(String action, dynamic message) {
    var socket = _socket;
    if (socket != null) {
      // Check if connected and emit
      if (socket.connected) {
        socket.emit(action, message);
        ref.invalidate(unreadCountProvider);
      } else {
        // Try to reconnect and emit again
        socket.io
          ..disconnect()
          ..connect();
        socket.once("connect", (_) {
          socket.emit(action, message);
        });
      }
    }
  }

  @override
  Future<void> closeConnection() async {
    _socket?.dispose();
    _socket = null;
  }
}
