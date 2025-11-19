import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String mobilePhone;
  final String email;
  final String? address;
  final String? additionalAddress;
  final String? country;
  final String? city;
  final String? postalCode;
  final String? bankName;
  final String? iBan;
  final String? bic;
  final String? avatar;

  const UserDetails({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.mobilePhone,
    required this.email,
    this.address,
    this.additionalAddress,
    this.country,
    this.city,
    this.postalCode,
    this.bankName,
    this.iBan,
    this.bic,
    this.avatar,
  });

  factory UserDetails.empty() {
    return const UserDetails(
      id: "",
      userId: "",
      firstName: "",
      lastName: "",
      mobilePhone: "",
      email: "",
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      firstName,
      lastName,
      mobilePhone,
      email,
      address,
      additionalAddress,
      country,
      city,
      postalCode,
      bankName,
      iBan,
      bic,
      avatar,
    ];
  }
}
