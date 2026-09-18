
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../services/auth_service_scope.dart';
import '../../theme/renon_colors.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  bool _isStoreOnline = true;

  Future<void> _logout() async {
    try {
      await AuthServiceScope.of(context).logout();

      if (!mounted) return;

      Navigator.of(context).pushNamedAndRemoveUntil(
        AppRoutes.welcome,
        (route) => false,
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not log out. Please try again.'),
        ),
      );
    }
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'Are you sure you want to log out of your Renon vendor account?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (shouldLogout != true || !mounted) return;

    await _logout();
  }

  @override
  Widget build(BuildContext context) {
    final session = AuthServiceScope.of(context).currentSession;

    final businessName =
        session?.businessName?.trim().isNotEmpty == true
            ? session!.businessName!
            : 'Your Store';

    final category =
        session?.category?.trim().isNotEmpty == true
            ? session!.category!
            : 'Business';

    return Scaffold(
      backgroundColor: RenonColors.ink,
      appBar: AppBar(
        backgroundColor: RenonColors.ink,
        elevation: 0,
        titleSpacing: 20,
        title: const Text(
          'Renon',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No new notifications.'),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
          ),
          IconButton(
            tooltip: 'Account',
            onPressed: () {
              _showAccountMenu(context);
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
          children: [
            Text(
              'Good afternoon 👋',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.55),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              businessName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: const TextStyle(
                color: Color(0xFF777E77),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 22),

            // STORE STATUS
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF1B201B),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFF2B312B),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: RenonColors.palm.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: RenonColors.palm,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Store status',
                          style: TextStyle(
                            color: Color(0xFF858C85),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: _isStoreOnline
                                  ? RenonColors.palm
                                  : const Color(0xFF777E77),
                              size: 9,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              _isStoreOnline
                                  ? 'Your store is open'
                                  : 'Your store is offline',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _isStoreOnline,
                    activeThumbColor: RenonColors.palm,
                    onChanged: (value) {
                      setState(() {
                        _isStoreOnline = value;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          content: Text(
                            value
                                ? 'Your store is now online.'
                                : 'Your store is now offline.',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // STATISTICS
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.payments_outlined,
                    title: '₦0',
                    subtitle: "Today's sales",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.shopping_bag_outlined,
                    title: '0',
                    subtitle: 'Pending orders',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Quick actions',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 13),

            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.add_box_outlined,
                    title: 'Add product',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.vendorProducts,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionCard(
                    icon: Icons.receipt_long_outlined,
                    title: 'View orders',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.vendorOrders,
                      );
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // RECENT ORDERS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent orders',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.vendorOrders,
                    );
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      color: RenonColors.palm,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFF151915),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    color: Color(0xFF626962),
                    size: 38,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No orders yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Your incoming orders will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF777E77),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111411),
        selectedIndex: 0,
        indicatorColor: RenonColors.palm.withValues(alpha: 0.18),
        onDestinationSelected: (index) {
          if (index == 0) {
            return;
          }

          if (index == 1) {
            Navigator.pushNamed(
              context,
              AppRoutes.vendorOrders,
            );
          }

          if (index == 2) {
            Navigator.pushNamed(
              context,
              AppRoutes.vendorProducts,
            );
          }

          if (index == 3) {
            _showStoreMenu(context);
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2_rounded),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.store_outlined),
            selectedIcon: Icon(Icons.store_rounded),
            label: 'Store',
          ),
        ],
      ),
    );
  }

  void _showAccountMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171B17),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A403A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 22),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // BUSINESS PROFILE
                _AccountMenuTile(
                  icon: Icons.person_outline_rounded,
                  title: 'Business profile',
                  subtitle: 'View and edit your business information',
                  onTap: () {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Business profile management is coming next.',
                        ),
                      ),
                    );
                  },
                ),

                // SWITCH ACCOUNT
                _AccountMenuTile(
                  icon: Icons.swap_horiz_rounded,
                  title: 'Switch account',
                  subtitle: 'Change to another Renon account type',
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamedAndRemoveUntil(
                      this.context,
                      AppRoutes.accountType,
                      (route) => false,
                      arguments: {
                        'mode': 'switch',
                        'currentAccountType': 'Vendor',
                      },
                    );
                  },
                ),

                // SETTINGS
                _AccountMenuTile(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  subtitle: 'Manage your Renon preferences',
                  onTap: () {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Settings are coming next.',
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 8),

                // LOG OUT
                _AccountMenuTile(
                  icon: Icons.logout_rounded,
                  title: 'Log out',
                  subtitle: 'Leave your vendor account',
                  isDanger: true,
                  onTap: () async {
                    Navigator.pop(context);

                    await _confirmLogout();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171B17),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A403A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 22),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Store',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // STORE STATUS
                _AccountMenuTile(
                  icon: Icons.storefront_outlined,
                  title: 'Store status',
                  subtitle: _isStoreOnline
                      ? 'Your store is currently online'
                      : 'Your store is currently offline',
                  onTap: () {
                    Navigator.pop(context);

                    setState(() {
                      _isStoreOnline = !_isStoreOnline;
                    });
                  },
                ),

                // MANAGE STORE
                _AccountMenuTile(
                  icon: Icons.storefront_outlined,
                  title: 'Manage store',
                  subtitle: 'Edit your store information and settings',
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(
                      this.context,
                      AppRoutes.vendorStore,
                    );
                  },
                ),

                // MANAGE PRODUCTS
                _AccountMenuTile(
                  icon: Icons.inventory_2_outlined,
                  title: 'Manage products',
                  subtitle: 'Add and manage your products',
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(
                      this.context,
                      AppRoutes.vendorProducts,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF1B201B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF2B312B),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: RenonColors.palm,
            size: 23,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF777E77),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFF1B201B),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF2B312B),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: RenonColors.palm,
                size: 26,
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AccountMenuTile extends StatelessWidget {
  const _AccountMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDanger = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 4,
      ),
      onTap: onTap,
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isDanger
              ? Colors.red.withValues(alpha: 0.10)
              : RenonColors.palm.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(
          icon,
          color: isDanger
              ? Colors.redAccent
              : RenonColors.palm,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDanger ? Colors.redAccent : Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF777E77),
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF626962),
      ),
    );
  }
}

