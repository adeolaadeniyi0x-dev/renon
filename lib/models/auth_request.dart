class LoginRequest {
  const LoginRequest({
    required this.emailOrPhone,
    required this.password,
    required this.accountType,
  });

  final String emailOrPhone;
  final String password;

  /// Customer, Vendor, Service Provider or Rider.
  final String accountType;
}

class SignupRequest {
  const SignupRequest({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.accountType,
    this.businessName,
    this.category,
    this.vehicleType,
  });

  final String fullName;
  final String email;
  final String phone;
  final String password;

  /// Customer, Vendor, Service Provider or Rider.
  final String accountType;

  /// Used by Vendors and Service Providers.
  final String? businessName;

  /// Used by Vendors and Service Providers.
  final String? category;

  /// Used by Riders.
  final String? vehicleType;
}

class ProfileSetupRequest {
  const ProfileSetupRequest({
    required this.campusOrArea,
    required this.address,
  });

  final String campusOrArea;
  final String address;
}