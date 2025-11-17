import '../../core/entities/user.dart';
import 'role_model.dart';

class UserModel extends User {
  const UserModel._({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.avatar,
    required super.organizationId,
    required super.organizationName,
    required super.isSubUser,
    required super.domain,
    required super.locationId,
    required super.locationName,
    required super.roles,
    required super.permissions,
    required super.departmentId,
    required super.organizationLogo,
    required super.createdAt,
    required super.updatedAt,
    required super.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel._(
      id: data['id'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      avatar: data['avatar'] ?? '',
      organizationId: data['organizationId'] ?? '',
      organizationName: data['organizationName'] ?? '',
      isSubUser: data['isSubUser'] ?? false,
      domain: data['domain'] ?? '',
      locationId: data['locationId'] ?? '',
      locationName: data['locationName'] ?? '',
      fcmToken: data['fcmToken'] ?? '',
      roles: data['roles'] != null
          ? List<RoleModel>.from(
              data['roles'].map((role) => RoleModel.fromJson(role)))
          : [],
      permissions: data['permissions'] != null
          ? List<String>.from(
              data['permissions'].map((permission) => permission))
          : [],
      departmentId: data['departmentId'] ?? '',
      organizationLogo: data['organizationLogo'] ?? '',
      createdAt: data['createdAt'] ?? DateTime.now().toIso8601String(),
      updatedAt: data['updatedAt'] ?? DateTime.now().toIso8601String(),
    );
  }
}
