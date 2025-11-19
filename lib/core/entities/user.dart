import 'package:equatable/equatable.dart';

import 'roles.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String avatar;
  final String organizationId;
  final String organizationName;
  final bool isSubUser;
  final String domain;
  final String locationId;
  final String locationName;
  final List<Role>? roles;
  final List<String>? permissions;
  final String fcmToken;
  final String departmentId;
  final String organizationLogo;
  final String createdAt;
  final String updatedAt;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatar,
    required this.organizationId,
    required this.organizationName,
    required this.isSubUser,
    required this.domain,
    required this.locationId,
    required this.locationName,
    this.roles,
    required this.fcmToken,
    required this.permissions,
    required this.departmentId,
    required this.organizationLogo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.empty() {
    return const User(
      id: "",
      firstName: "",
      lastName: "",
      email: "",
      avatar: "",
      organizationId: "",
      organizationName: "",
      isSubUser: false,
      domain: "",
      locationId: "",
      locationName: "",
      roles: [],
      fcmToken: "",
      permissions: [],
      departmentId: "",
      organizationLogo: "",
      createdAt: "",
      updatedAt: "",
    );
  }

  String get fullName => "$firstName $lastName";

  @override
  List<Object> get props {
    return [
      id,
      firstName,
      lastName,
      email,
      avatar,
      organizationId,
      organizationName,
      isSubUser,
      domain,
      locationId,
      locationName,
      roles ?? [],
      permissions ?? [],
      departmentId,
      fcmToken,
      organizationLogo,
      createdAt,
      updatedAt,
    ];
  }
}
