import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/auth_request.dart';
import '../../services/auth_service_scope.dart';
import '../../services/auth_validators.dart';
import '../../services/mock_auth_service.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/auth_screen_shell.dart';
import '../../widgets/form_error_banner.dart';
import '../../widgets/renon_buttons.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() =>
      _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _areaController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  String _accountType = 'Customer';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final session =
        AuthServiceScope.of(context).currentSession;

    if (session != null) {
      _accountType = session.accountType;
    }
  }

  @override
  void dispose() {
    _areaController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String get _title {
    switch (_accountType) {
      case 'Vendor':
        return 'Set up your store';

      case 'Service Provider':
        return 'Set up your service';

      case 'Rider':
        return 'Set up your rider profile';

      default:
        return 'Set up your profile';
    }
  }

  String get _subtitle {
    switch (_accountType) {
      case 'Vendor':
        return 'Tell us where your business operates so customers can find you.';

      case 'Service Provider':
        return 'Tell us where you provide your services.';

      case 'Rider':
        return 'Tell us where you operate so Renon can connect you with deliveries.';

      default:
        return 'Add your location so Renon can shape your local experience.';
    }
  }

  String get _areaLabel {
    switch (_accountType) {
      case 'Vendor':
        return 'Business area';

      case 'Service Provider':
        return 'Service area';

      case 'Rider':
        return 'Operating area';

      default:
        return 'Campus or area';
    }
  }

  String get _addressLabel {
    switch (_accountType) {
      case 'Vendor':
        return 'Business address';

      case 'Service Provider':
        return 'Service address';

      case 'Rider':
        return 'Operating address';

      default:
        return 'Delivery address';
    }
  }

  String get _areaHint {
    switch (_accountType) {
      case 'Vendor':
        return 'e.g. Oye-Ekiti';

      case 'Service Provider':
        return 'e.g. Lagos Island';

      case 'Rider':
        return 'e.g. Ikeja';

      default:
        return 'e.g. Oye-Ekiti';
    }
  }

  String get _addressHint {
    switch (_accountType) {
      case 'Vendor':
        return 'Enter your business location';

      case 'Service Provider':
        return 'Enter your service location';

      case 'Rider':
        return 'Enter your operating address';

      default:
        return 'Enter your delivery address';
    }
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
      final session =
          await AuthServiceScope.of(context).completeProfile(
        ProfileSetupRequest(
          campusOrArea: _areaController.text.trim(),
          address: _addressController.text.trim(),
        ),
      );

      if (!mounted) return;

      switch (session.accountType) {
      case 'Vendor':
  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.vendorHome,
    (route) => false,
  );
  break;

        case 'Customer':
        case 'Service Provider':
        case 'Rider':
        default:
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.customerHome,
            (route) => false,
          );
      }
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
      title: _title,
      subtitle: _subtitle,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            FormErrorBanner(
              message: _errorMessage,
            ),

            if (_errorMessage != null)
              const SizedBox(height: RenonSpacing.md),

            TextFormField(
              controller: _areaController,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: (value) =>
                  AuthValidators.requiredText(
                value,
                _areaLabel,
              ),
              decoration: InputDecoration(
                labelText: _areaLabel,
                hintText: _areaHint,
                prefixIcon: const Icon(
                  Icons.location_on_outlined,
                ),
              ),
            ),

            const SizedBox(height: RenonSpacing.md),

            TextFormField(
              controller: _addressController,
              minLines: 3,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.sentences,
              validator: (value) =>
                  AuthValidators.requiredText(
                value,
                _addressLabel,
              ),
              decoration: InputDecoration(
                labelText: _addressLabel,
                hintText: _addressHint,
                prefixIcon: const Icon(
                  Icons.home_outlined,
                ),
              ),
            ),

            const SizedBox(height: RenonSpacing.xl),

            RenonPrimaryButton(
              label: 'Finish setup',
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}