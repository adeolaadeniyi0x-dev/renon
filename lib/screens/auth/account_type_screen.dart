
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../theme/renon_colors.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/renon_logo.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  String? selectedType;
  bool _isSwitchingAccount = false;
  String? _currentAccountType;

  final List<_AccountType> accountTypes = const [
    _AccountType(
      title: 'Customer',
      subtitle: 'Discover products and services around you.',
      icon: Icons.shopping_bag_outlined,
    ),
    _AccountType(
      title: 'Vendor',
      subtitle: 'Sell products and grow your business.',
      icon: Icons.storefront_outlined,
    ),
    _AccountType(
      title: 'Service Provider',
      subtitle: 'Offer your skills and services to people nearby.',
      icon: Icons.handyman_outlined,
    ),
    _AccountType(
      title: 'Rider',
      subtitle: 'Deliver orders and earn on your schedule.',
      icon: Icons.delivery_dining_outlined,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Map<String, dynamic>) {
      _isSwitchingAccount = arguments['mode'] == 'switch';
      _currentAccountType = arguments['currentAccountType'];
    }
  }

  void _continue() {
    if (selectedType == null) {
      return;
    }

    if (_isSwitchingAccount) {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.login,
        arguments: selectedType,
      );
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.signup,
      arguments: selectedType,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.ink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: RenonSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              Center(
                child: RenonLogo(
                  size: 46,
                  showWordmark: true,
                  onDark: true,
                ),
              ),

              const SizedBox(height: 48),

              Text(
                _isSwitchingAccount
                    ? 'Switch account'
                    : 'How will you use Renon?',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 29,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                  letterSpacing: -0.8,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                _isSwitchingAccount
                    ? 'Choose the account type you want to use on Renon.'
                    : 'Choose an account type to get started.',
                style: const TextStyle(
                  color: RenonColors.softText,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              if (_isSwitchingAccount &&
                  _currentAccountType != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF202520),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF303530),
                    ),
                  ),
                  child: Text(
                    'Currently using $_currentAccountType',
                    style: const TextStyle(
                      color: Color(0xFF969D97),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 28),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: accountTypes.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final account = accountTypes[index];
                    final isSelected =
                        selectedType == account.title;

                    return _AccountTypeCard(
                      account: account,
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          selectedType = account.title;
                        });
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                      selectedType == null ? null : _continue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC6F135),
                    foregroundColor: const Color(0xFF171B18),
                    disabledBackgroundColor:
                        const Color(0xFF303530),
                    disabledForegroundColor:
                        const Color(0xFF777D78),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    _isSwitchingAccount
                        ? 'Continue to sign in'
                        : 'Continue',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountTypeCard extends StatelessWidget {
  const _AccountTypeCard({
    required this.account,
    required this.selected,
    required this.onTap,
  });

  final _AccountType account;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFC6F135).withValues(alpha: 0.08)
              : const Color(0xFF202520),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xFFC6F135)
                : const Color(0xFF303530),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFC6F135)
                    : const Color(0xFF292E2A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                account.icon,
                color: selected
                    ? const Color(0xFF171B18)
                    : Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    account.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    account.subtitle,
                    style: const TextStyle(
                      color: Color(0xFF8D948F),
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              selected
                  ? Icons.check_circle_rounded
                  : Icons.arrow_forward_ios_rounded,
              color: selected
                  ? const Color(0xFFC6F135)
                  : const Color(0xFF686E69),
              size: selected ? 23 : 16,
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountType {
  const _AccountType({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

