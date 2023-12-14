import 'package:hive_flutter/hive_flutter.dart';

part 'role_model.g.dart';

@HiveType(typeId: 2)
class RoleModel {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final List<String> permissions;

  RoleModel({
    required this.id,
    required this.name,
    required this.permissions,
  });

  factory RoleModel.fromMap(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        name: json["name"],
        permissions: json["permissions"] == null || json["permissions"] == ""
            ? []
            : List<String>.from(json["permissions"].split(",").map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "permissions": List<String>.from(permissions.map((x) => x)),
      };
}
