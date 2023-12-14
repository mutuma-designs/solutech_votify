import '../../domain/entities/role.dart';
import '../models/role_model.dart';

extension RoleModelX on RoleModel {
  Role toEntity() {
    return Role(
      id: id,
      name: name,
      permissions: permissions,
    );
  }
}

extension RoleX on Role {
  RoleModel toModel() {
    return RoleModel(
      id: id,
      name: name,
      permissions: permissions,
    );
  }
}
