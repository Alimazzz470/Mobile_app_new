import '../../core/entities/roles.dart';

class RoleModel extends Role {
  const RoleModel._({
    required super.id,
    required super.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> data) {
    return RoleModel._(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
    );
  }
}
