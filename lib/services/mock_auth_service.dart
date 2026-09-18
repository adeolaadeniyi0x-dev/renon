import '../models/auth_request.dart';
import '../models/auth_session.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;
}

class MockAuthService {
  AuthSession? _pendingSession;

  AuthSession? get currentSession => _pendingSession;
  Future<void> logout() async {
  await Future<void>.delayed(
    const Duration(milliseconds: 200),
  );

  _pendingSession = null;
}

  Future<AuthSession> login(LoginRequest request) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 650),
    );

    if (request.password.toLowerCase() == 'password') {
      throw const AuthException(
        'Please choose a stronger password.',
      );
    }

    if (request.emailOrPhone.toLowerCase().contains('blocked')) {
      throw const AuthException(
        'This account needs support review before sign in.',
      );
    }

    final accountType = request.accountType;

    _pendingSession = AuthSession(
      userId:
          'mock-${accountType.toLowerCase().replaceAll(' ', '-')}-001',
      fullName: _displayNameFor(accountType),
      email: request.emailOrPhone.contains('@')
          ? request.emailOrPhone
          : '',
      phone: request.emailOrPhone.contains('@')
          ? ''
          : request.emailOrPhone,
      accountType: accountType,
      businessName: _businessNameFor(accountType),
      category: _categoryFor(accountType),
      vehicleType: _vehicleTypeFor(accountType),
      isProfileComplete: true,
    );

    return _pendingSession!;
  }

  Future<AuthSession> signup(SignupRequest request) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 700),
    );

    if (request.email.toLowerCase().contains('taken')) {
      throw const AuthException(
        'An account already exists with this email.',
      );
    }

    _pendingSession = AuthSession(
      userId:
          'mock-${request.accountType.toLowerCase().replaceAll(' ', '-')}-002',
      fullName: request.fullName,
      email: request.email,
      phone: request.phone,
      accountType: request.accountType,
      businessName: request.businessName,
      category: request.category,
      vehicleType: request.vehicleType,
      isProfileComplete: false,
    );

    return _pendingSession!;
  }

  Future<AuthSession> verifyOtp(String otp) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 550),
    );

    if (otp != '123456') {
      throw const AuthException(
        'Enter the 6-digit code sent to you.',
      );
    }

    return _pendingSession ??
        const AuthSession(
          userId: 'mock-customer-003',
          fullName: 'Renon Customer',
          email: '',
          phone: '',
          accountType: 'Customer',
          isProfileComplete: false,
        );
  }

  Future<AuthSession> completeProfile(
    ProfileSetupRequest request,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 600),
    );

    if (request.address.length < 8) {
      throw const AuthException(
        'Please enter a more complete address.',
      );
    }

    final session = _pendingSession ??
        const AuthSession(
          userId: 'mock-customer-004',
          fullName: 'Renon Customer',
          email: '',
          phone: '',
          accountType: 'Customer',
          isProfileComplete: false,
        );

    _pendingSession = session.copyWith(
      isProfileComplete: true,
    );

    return _pendingSession!;
  }

  String _displayNameFor(String accountType) {
    switch (accountType) {
      case 'Vendor':
        return 'Renon Vendor';
      case 'Service Provider':
        return 'Renon Service Provider';
      case 'Rider':
        return 'Renon Rider';
      default:
        return 'Renon Customer';
    }
  }

  String? _businessNameFor(String accountType) {
    switch (accountType) {
      case 'Vendor':
        return 'Renon Demo Store';
      case 'Service Provider':
        return 'Renon Demo Services';
      default:
        return null;
    }
  }

  String? _categoryFor(String accountType) {
    switch (accountType) {
      case 'Vendor':
        return 'General';
      case 'Service Provider':
        return 'Services';
      default:
        return null;
    }
  }

  String? _vehicleTypeFor(String accountType) {
    if (accountType == 'Rider') {
      return 'Motorcycle';
    }

    return null;
  }
}