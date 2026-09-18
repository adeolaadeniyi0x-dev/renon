class AuthValidators {
  const AuthValidators._();

  static String? requiredText(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label is required.';
    }
    return null;
  }

  static String? email(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Email address is required.';
    }
    final isEmail = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(input);
    if (!isEmail) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? phone(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Phone number is required.';
    }
    final isPhone = RegExp(r'^(?:\+234|0)[789][01]\d{8}$').hasMatch(input);
    if (!isPhone) {
      return 'Enter a valid Nigerian phone number.';
    }
    return null;
  }

  static String? emailOrPhone(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) {
      return 'Email or phone number is required.';
    }
    if (input.contains('@')) {
      return email(input);
    }
    return phone(input);
  }

  static String? password(String? value) {
    final input = value ?? '';
    if (input.isEmpty) {
      return 'Password is required.';
    }
    if (input.length < 8) {
      return 'Use at least 8 characters.';
    }
    return null;
  }

  static String? otp(String? value) {
    final input = value?.trim() ?? '';
    if (input.length != 6) {
      return 'Enter the 6-digit code.';
    }
    return null;
  }
}
