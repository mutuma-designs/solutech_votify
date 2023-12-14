import '../../config/constants.dart';

extension ImageStringX on String {
  String get toAvatarUrl {
    if (startsWith("avatars")) return "$apiUrl/users/$this";
    return this;
  }
}
