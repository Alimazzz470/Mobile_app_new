import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/exceptions/no_stored_token_exception.dart';
import '../models/token_model.dart';

class TokenDataSource {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
      resetOnError: true,
    ),
  );

  static const String _tokenKey = "token";

  Future<void> save(TokenModel token) async {
    try {
      await _storage.write(key: _tokenKey, value: jsonEncode(token.toJson));
    } catch (_, s) {
      Error.throwWithStackTrace(Exception("Could not write key"), s);
    }
  }

  Future<TokenModel> get() async {
    final data = await _storage.read(key: _tokenKey);

    if (data == null) {
      throw const NoStoredTokenException();
    }

    return TokenModel.fromJson(jsonDecode(data));
  }

  Future<void> clear() async {
    var hasKey = await _storage.containsKey(key: _tokenKey);
    if (!hasKey) return;

    try {
      await _storage.delete(key: _tokenKey);
    } catch (_, s) {
      Error.throwWithStackTrace(Exception("Could not delete key"), s);
    }
  }
}
