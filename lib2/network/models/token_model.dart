import '../../core/entities/token.dart';

class TokenModel extends Token {
  TokenModel._({
    required super.accessToken,
    required super.refreshToken,
    required super.expiresIn,
    required super.refreshExpiresIn,
    required super.created,
  });

  factory TokenModel.fromJson(Map<String, dynamic> data) {
    return TokenModel._(
      accessToken: data['accessToken'],
      refreshToken: data['refreshToken'] ?? "",
      expiresIn: data['expiresIn'] ?? 3600,
      refreshExpiresIn: data["refreshExpiresIn"] ?? 3600,
      created: data.containsKey('created') ? DateTime.parse(data['created']) : DateTime.now(),
    );
  }

  Map<String, dynamic> get toJson {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'refreshExpiresIn': refreshExpiresIn,
      'created': created.toIso8601String()
    };
  }
}
