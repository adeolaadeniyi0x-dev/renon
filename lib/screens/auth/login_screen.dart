import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/auth_request.dart';
import '../../services/auth_service_scope.dart';
import '../../services/auth_validators.dart';
import '../../services/mock_auth_service.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/auth_screen_shell.dart';
import '../../widgets/form_error_banner.dart';
import '../../widgets/password_field.dart';
import '../../widgets/renon_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _argumentsLoaded = false;
  String? _errorMessage;
  String _accountType = 'Customer';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_argumentsLoaded) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments is String && arguments.isNotEmpty) {
        _accountType = arguments;
      }

      _argumentsLoaded = true;
    }
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await AuthServiceScope.of(context).login(
        LoginRequest(
          emailOrPhone: _emailOrPhoneController.text.trim(),
          password: _passwordController.text,
          accountType: _accountType,
        ),
      );

      if (!mounted) return;

      _goToDashboard();
    } on AuthException catch (error) {
      if (mounted) {
        setState(() => _errorMessage = error.message);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _goToDashboard() {
    switch (_accountType) {
      case 'Vendor':
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.vendorHome,
          (route) => false,
        );
        break;

      case 'Rider':
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.riderHome,
          (route) => false,
        );
        break;

      case 'Service Provider':
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.serviceProviderHome,
          (route) => false,
        );
        break;

      case 'Customer':
      default:
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.customerHome,
          (route) => false,
        );
        break;
    }
  }

  String get _subtitle {
    switch (_accountType) {
      case 'Vendor':
        return 'Sign in to manage your store, products and orders on Renon.';
      case 'Service Provider':
        return 'Sign in to manage your services and connect with customers.';
      case 'Rider':
        return 'Sign in to manage deliveries and start earning with Renon.';
      default:
        return 'Sign in to continue shopping and tracking orders on Renon.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      title: 'Welcome back',
      subtitle: _subtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormErrorBanner(message: _errorMessage),

            if (_errorMessage != null)
              const SizedBox(height: RenonSpacing.md),

            TextFormField(
              controller: _emailOrPhoneController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.telephoneNumber,
              ],
              validator: AuthValidators.emailOrPhone,
              decoration: const InputDecoration(
                labelText: 'Email or phone number',
                prefixIcon: Icon(Icons.alternate_email_rounded),
              ),
            ),

            const SizedBox(height: RenonSpacing.md),

            PasswordField(
              controller: _passwordController,
              label: 'Password',
              textInputAction: TextInputAction.done,
              validator: AuthValidators.password,
            ),

            const SizedBox(height: RenonSpacing.xl),

            RenonPrimaryButton(
              label: 'Sign in',
              isLoading: _isLoading,
              onPressed: _submit,
            ),

            const SizedBox(height: RenonSpacing.md),

            RenonSecondaryButton(
              label: 'Create an account',
              onPressed: _isLoading
                  ? null
                  : () => Navigator.pushNamed(
                        context,
                        AppRoutes.signup,
                        arguments: _accountType,
                      ),
            ),

            const SizedBox(height: RenonSpacing.sm),

            RenonSecondaryButton(
              label: 'Continue as Demo',
              onPressed: _isLoading ? null : _goToDashboard,
            ),
          ],
        ),
      ),
    );
  }
}