import 'package:flutter/material.dart';

import '../app/app_routes.dart';
import 'auth_service_scope.dart';

class LogoutService {
  const LogoutService._();

  static Future<void> logout(BuildContext context) async {
    await AuthServiceScope.of(context).logout();

    if (!context.mounted) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.welcome,
      (route) => false,
    );
  }
}