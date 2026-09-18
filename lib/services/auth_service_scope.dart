import 'package:flutter/widgets.dart';

import 'mock_auth_service.dart';

class AuthServiceScope extends InheritedWidget {
  const AuthServiceScope({
    super.key,
    required this.authService,
    required super.child,
  });

  final MockAuthService authService;

  static MockAuthService of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthServiceScope>();
    assert(scope != null, 'AuthServiceScope was not found in the widget tree.');
    return scope!.authService;
  }

  @override
  bool updateShouldNotify(AuthServiceScope oldWidget) {
    return authService != oldWidget.authService;
  }
}
