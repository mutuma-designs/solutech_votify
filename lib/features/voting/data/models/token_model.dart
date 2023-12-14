import 'package:hive_flutter/hive_flutter.dart';

part 'token_model.g.dart';

@HiveType(typeId: 8)
class TokenModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String token;
  @HiveField(2)
  final DateTime expiresAt;

  TokenModel({
    required this.id,
    required this.token,
    required this.expiresAt,
  });

  static TokenModel fromMap(Map<String, dynamic> map) {
    return TokenModel(
      id: map['id'],
      token: map['token'],
      expiresAt: DateTime.parse(map['expiresAt']),
    );
  }
}
