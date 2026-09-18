import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/auth_request.dart';
import '../../services/auth_service_scope.dart';
import '../../services/auth_validators.dart';
import '../../services/mock_auth_service.dart';
import '../../theme/renon_colors.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/form_error_banner.dart';
import '../../widgets/password_field.dart';
import '../../widgets/renon_buttons.dart';
import '../../widgets/renon_logo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _categoryController = TextEditingController();
  final _vehicleController = TextEditingController();
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
    _nameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _categoryController.dispose();
    _vehicleController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get _isBusiness =>
      _accountType == 'Vendor' ||
      _accountType == 'Service Provider';

  bool get _isRider => _accountType == 'Rider';

  String get _description {
    switch (_accountType) {
      case 'Vendor':
        return 'Set up your business account and start selling on Renon.';
      case 'Service Provider':
        return 'Set up your service profile and connect with customers.';
      case 'Rider':
        return 'Create your rider account and start earning with Renon.';
      default:
        return 'Create your account and discover trusted people, products and services.';
    }
  }

  IconData get _accountIcon {
    switch (_accountType) {
      case 'Vendor':
        return Icons.storefront_outlined;
      case 'Service Provider':
        return Icons.handyman_outlined;
      case 'Rider':
        return Icons.delivery_dining_outlined;
      default:
        return Icons.shopping_bag_outlined;
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
      await AuthServiceScope.of(context).signup(
        SignupRequest(
          fullName: _nameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
          password: _passwordController.text,
          accountType: _accountType,
          businessName: _isBusiness
              ? _businessNameController.text.trim()
              : null,
          category: _isBusiness
              ? _categoryController.text.trim()
              : null,
          vehicleType: _isRider
              ? _vehicleController.text.trim()
              : null,
        ),
      );

      if (!mounted) return;

      Navigator.pushNamed(
        context,
        AppRoutes.otpVerification,
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
    return Scaffold(
      backgroundColor: RenonColors.ink,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              RenonSpacing.lg,
              20,
              RenonSpacing.lg,
              30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 38),

                // Account type badge.
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC6F135)
                        .withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFFC6F135)
                          .withValues(alpha: 0.18),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _accountIcon,
                        color: const Color(0xFFC6F135),
                        size: 17,
                      ),
                      const SizedBox(width: 7),
                      Text(
                        '$_accountType account',
                        style: const TextStyle(
                          color: Color(0xFFC6F135),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  _accountType == 'Customer'
                      ? 'Create your\naccount.'
                      : 'Set up your\n$_accountType account.',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                    letterSpacing: -1,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  _description,
                  style: const TextStyle(
                    color: RenonColors.softText,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 25),

                _buildSelectedAccountCard(),

                const SizedBox(height: 24),

                Form(
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

                      _buildField(
                        controller: _nameController,
                        label: 'Full name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        textCapitalization:
                            TextCapitalization.words,
                        autofillHints: const [
                          AutofillHints.name,
                        ],
                        validator: (value) =>
                            AuthValidators.requiredText(
                          value,
                          'Full name',
                        ),
                      ),

                      // Vendor / Service Provider fields.
                      if (_isBusiness) ...[
                        const SizedBox(height: 14),

                        _buildField(
                          controller: _businessNameController,
                          label: _accountType == 'Vendor'
                              ? 'Business name'
                              : 'Service name',
                          hint: _accountType == 'Vendor'
                              ? 'e.g. Adeola Stores'
                              : 'e.g. Adeola Graphics',
                          icon: Icons.business_outlined,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              AuthValidators.requiredText(
                            value,
                            _accountType == 'Vendor'
                                ? 'Business name'
                                : 'Service name',
                          ),
                        ),

                        const SizedBox(height: 14),

                        _buildField(
                          controller: _categoryController,
                          label: _accountType == 'Vendor'
                              ? 'Business category'
                              : 'Service category',
                          hint: _accountType == 'Vendor'
                              ? 'e.g. Fashion, Food, Electronics'
                              : 'e.g. Design, Repairs, Cleaning',
                          icon: Icons.category_outlined,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              AuthValidators.requiredText(
                            value,
                            _accountType == 'Vendor'
                                ? 'Business category'
                                : 'Service category',
                          ),
                        ),
                      ],

                      const SizedBox(height: 14),

                      _buildField(
                        controller: _emailController,
                        label: 'Email address',
                        hint: 'you@example.com',
                        icon: Icons.mail_outline_rounded,
                        keyboardType:
                            TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [
                          AutofillHints.email,
                        ],
                        validator: AuthValidators.email,
                      ),

                      const SizedBox(height: 14),

                      _buildField(
                        controller: _phoneController,
                        label: 'Phone number',
                        hint: '+234 800 000 0000',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [
                          AutofillHints.telephoneNumber,
                        ],
                        validator: AuthValidators.phone,
                      ),

                      // Rider field.
                      if (_isRider) ...[
                        const SizedBox(height: 14),

                        _buildField(
                          controller: _vehicleController,
                          label: 'Vehicle type',
                          hint: 'e.g. Motorcycle, Bicycle, Car',
                          icon: Icons.two_wheeler_outlined,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              AuthValidators.requiredText(
                            value,
                            'Vehicle type',
                          ),
                        ),
                      ],

                      const SizedBox(height: 14),

                      PasswordField(
                        controller: _passwordController,
                        label: 'Password',
                        textInputAction: TextInputAction.done,
                        validator: AuthValidators.password,
                      ),

                      const SizedBox(height: 28),

                      RenonPrimaryButton(
                        label: 'Create account',
                        isLoading: _isLoading,
                        onPressed: _submit,
                      ),

                      const SizedBox(height: 14),

                      RenonSecondaryButton(
                        label: 'I already have an account',
                        onPressed: _isLoading
                            ? null
                            : () => Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                  arguments: _accountType,
                                ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Center(
                  child: Text(
                    'By creating an account, you agree to Renon\'s\n'
                    'Terms of Service and Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF626862),
                      fontSize: 10.5,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          onPressed: _isLoading
              ? null
              : () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
          ),
          color: Colors.white,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
        ),
        const Spacer(),
        const RenonLogo(
          size: 40,
          showWordmark: true,
          onDark: true,
        ),
        const Spacer(),
        const SizedBox(width: 42),
      ],
    );
  }

  Widget _buildSelectedAccountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF202520),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF303530),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFFC6F135),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              _accountIcon,
              color: const Color(0xFF171B18),
              size: 22,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account type',
                  style: TextStyle(
                    color: Color(0xFF7F867F),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _accountType,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _isLoading
                ? null
                : () => Navigator.pop(context),
            child: const Text(
              'Change',
              style: TextStyle(
                color: Color(0xFFC6F135),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required TextInputType keyboardType,
    required TextInputAction textInputAction,
    required FormFieldValidator<String> validator,
    Iterable<String>? autofillHints,
    TextCapitalization textCapitalization =
        TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      autofillHints: autofillHints,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF777E78),
          size: 21,
        ),
        filled: true,
        fillColor: const Color(0xFF202520),
        labelStyle: const TextStyle(
          color: Color(0xFF969D97),
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF5F665F),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFF303530),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFF303530),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFC6F135),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE57373),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFE57373),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}