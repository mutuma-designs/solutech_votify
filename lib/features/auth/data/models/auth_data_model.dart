import 'package:hive/hive.dart';

import '../../../users/data/models/user_model.dart';

part 'auth_data_model.g.dart';

@HiveType(typeId: 1)
class AuthDataModel {
  @HiveField(1)
  final UserModel user;
  @HiveField(2)
  final String token;

  AuthDataModel({
    required this.user,
    required this.token,
  });

  factory AuthDataModel.fromMap(Map<String, dynamic> json) => AuthDataModel(
        user: UserModel.fromMap(json["user"]),
        token: json["token"],
      );
}
