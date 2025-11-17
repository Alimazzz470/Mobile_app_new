class UserDetailsInput {
  final String firstName;
  final String lastName;
  final String mobilePhone;
  final String? personalEmail;
  final String? password;
  final String? address;
  final String? additionalAddress;
  final String? country;
  final String? city;
  final String? postalCode;
  final String? bankName;
  final String? iBan;
  final String? bic;
  final bool avatar;

  const UserDetailsInput({
    required this.firstName,
    required this.lastName,
    required this.mobilePhone,
    required this.personalEmail,
    this.password,
    required this.address,
    required this.additionalAddress,
    required this.country,
    required this.city,
    required this.postalCode,
    required this.bankName,
    required this.iBan,
    required this.bic,
    required this.avatar,
  });

  Map<String, dynamic> get toJson => {
        "firstName": firstName,
        "lastName": lastName,
        "mobilePhone": mobilePhone,
        "personalEmail": personalEmail,
        "password": password,
        "address": address,
        "address2": additionalAddress,
        "country": country,
        "city": city,
        "postalCode": postalCode,
        "bankName": bankName,
        "iBan": iBan,
        "bic": bic,
        "avatar": avatar,
      }..removeWhere((key, value) => value == null);
}
