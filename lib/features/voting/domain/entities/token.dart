class Token {
  final int id;
  final String token;
  final DateTime expiresAt;

  bool get isExpired {
    return DateTime.now().isAfter(expiresAt);
  }

  Token({
    required this.id,
    required this.token,
    required this.expiresAt,
  });
}
