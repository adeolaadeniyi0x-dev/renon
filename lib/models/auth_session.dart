class AuthSession {
  const AuthSession({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.accountType,
    required this.isProfileComplete,
    this.businessName,
    this.category,
    this.vehicleType,
  });

  final String userId;
  final String fullName;
  final String email;
  final String phone;

  /// Customer, Vendor, Service Provider or Rider.
  final String accountType;

  /// Vendor / Service Provider information.
  final String? businessName;
  final String? category;

  /// Rider information.
  final String? vehicleType;

  final bool isProfileComplete;

  AuthSession copyWith({
    String? fullName,
    String? email,
    String? phone,
    String? accountType,
    String? businessName,
    String? category,
    String? vehicleType,
    bool? isProfileComplete,
  }) {
    return AuthSession(
      userId: userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      accountType: accountType ?? this.accountType,
      businessName: businessName ?? this.businessName,
      category: category ?? this.category,
      vehicleType: vehicleType ?? this.vehicleType,
      isProfileComplete:
          isProfileComplete ?? this.isProfileComplete,
    );
  }
}