import '../../core/entities/user_details.dart';

class UserDetailsModel extends UserDetails {
  const UserDetailsModel._({
    required super.id,
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.mobilePhone,
    required super.email,
    required super.address,
    required super.additionalAddress,
    required super.country,
    required super.city,
    required super.postalCode,
    required super.bankName,
    required super.iBan,
    required super.bic,
    required super.avatar,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> data) {
    return UserDetailsModel._(
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      mobilePhone: data['mobilePhone'] ?? '',
      email: data['personalEmail'] ?? '',
      address: data['address'] ?? '',
      additionalAddress: data['address2'] ?? '',
      country: data['country'] ?? '',
      city: data['city'] ?? '',
      postalCode: data['postalCode'] ?? '',
      bankName: data['bankName'] ?? '',
      iBan: data['iBan'] ?? '',
      bic: data['bic'] ?? '',
      avatar: data['avatar'] ?? '',
    );
  }
}
