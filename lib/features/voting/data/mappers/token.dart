import '../../domain/entities/token.dart';
import '../models/token_model.dart';

extension TokenX on Token {
  TokenModel toModel() {
    return TokenModel(
      id: id,
      token: token,
      expiresAt: expiresAt,
    );
  }
}

extension TokenModelX on TokenModel {
  Token toEntity() {
    return Token(
      id: id,
      token: token,
      expiresAt: expiresAt,
    );
  }
}
