import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../services/auth_service_scope.dart';
import '../../services/auth_validators.dart';
import '../../services/mock_auth_service.dart';

import '../../theme/renon_spacing.dart';
import '../../widgets/auth_screen_shell.dart';
import '../../widgets/form_error_banner.dart';
import '../../widgets/otp_input.dart';
import '../../widgets/renon_buttons.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _otpController.dispose();
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
      await AuthServiceScope.of(context)
          .verifyOtp(_otpController.text.trim());

      if (!mounted) return;

      Navigator.pushNamed(
        context,
        AppRoutes.profileSetup,
      );
    } on AuthException catch (error) {
      if (mounted) {
        setState(() {
          _errorMessage = error.message;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      title: 'Verify your number',
      subtitle:
          'Enter the 6-digit code sent to your Renon signup contact.',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormErrorBanner(
              message: _errorMessage,
            ),

            if (_errorMessage != null)
              const SizedBox(
                height: RenonSpacing.md,
              ),

            OtpInput(
              controller: _otpController,
              validator: AuthValidators.otp,
            ),

            const SizedBox(height: RenonSpacing.md),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF202520),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFF303530),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFC6F135),
                    size: 18,
                  ),
                  SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Use 123456 for this local mock flow.',
                      style: TextStyle(
                        color: Color(0xFF9BA19B),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: RenonSpacing.xl),

            RenonPrimaryButton(
              label: 'Verify code',
              isLoading: _isLoading,
              onPressed: _submit,
            ),

            const SizedBox(height: RenonSpacing.md),

            RenonSecondaryButton(
              label: 'Back to sign up',
              onPressed: _isLoading
                  ? null
                  : () => Navigator.pop(context),
            ),

            const SizedBox(height: RenonSpacing.lg),

            GestureDetector(
              onTap: _isLoading
                  ? null
                  : () {
                      _otpController.clear();
                      setState(() {
                        _errorMessage = null;
                      });
                    },
              child: const Text(
                'Didn\'t receive the code? Try again',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFC6F135),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}