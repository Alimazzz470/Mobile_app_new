class Token {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final int refreshExpiresIn;
  final DateTime created;

  const Token({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresIn,
    required this.created,
  });

  bool get hasExpired {
    var expires = created.add(Duration(seconds: expiresIn));
    return expires.difference(DateTime.now()).isNegative;
  }
}
