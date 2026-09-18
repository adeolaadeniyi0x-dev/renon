import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../services/auth_service_scope.dart';
import '../../theme/renon_colors.dart';
import 'rider_deliveries_screen.dart';
import 'rider_earnings_screen.dart';
import 'rider_help_support_screen.dart';
import 'rider_notifications_screen.dart';
import 'rider_settings_screen.dart';
import 'rider_vehicle_screen.dart';
import 'rider_verification_screen.dart';

class RiderHomeScreen extends StatefulWidget {
  const RiderHomeScreen({super.key});

  @override
  State<RiderHomeScreen> createState() => _RiderHomeScreenState();
}

class _RiderHomeScreenState extends State<RiderHomeScreen> {
  bool _isOnline = true;
  int _selectedIndex = 0;

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ============================================================
  // LOGOUT
  // ============================================================

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

      _showMessage(
        'Could not log out. Please try again.',
      );
    }
  }

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: RenonColors.paper,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Log out?',
            style: TextStyle(
              color: RenonColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'You will be signed out of your rider account and returned to the Welcome screen.',
            style: TextStyle(
              color: RenonColors.muted,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: RenonColors.muted,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await _logout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RenonColors.danger,
                foregroundColor: RenonColors.paper,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'Log out',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // MAIN
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.cream,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomePage(),
          const RiderDeliveriesScreen(),
          const RiderEarningsScreen(),
          _buildProfilePage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigationBar() {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: RenonColors.paper,
          border: const Border(
            top: BorderSide(
              color: RenonColors.line,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 15,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          backgroundColor: RenonColors.paper,
          elevation: 0,
          height: 70,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _selectTab,
          indicatorColor: RenonColors.lime,
          labelBehavior:
              NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: RenonColors.muted,
              ),
              selectedIcon: Icon(
                Icons.home_rounded,
                color: RenonColors.forest,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.local_shipping_outlined,
                color: RenonColors.muted,
              ),
              selectedIcon: Icon(
                Icons.local_shipping_rounded,
                color: RenonColors.forest,
              ),
              label: 'Deliveries',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                color: RenonColors.muted,
              ),
              selectedIcon: Icon(
                Icons.account_balance_wallet_rounded,
                color: RenonColors.forest,
              ),
              label: 'Earnings',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_outline_rounded,
                color: RenonColors.muted,
              ),
              selectedIcon: Icon(
                Icons.person_rounded,
                color: RenonColors.forest,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HOME
  // ============================================================

  Widget _buildHomePage() {
    return RefreshIndicator(
      color: RenonColors.forest,
      onRefresh: () async {
        await Future<void>.delayed(
          const Duration(milliseconds: 500),
        );

        if (mounted) {
          setState(() {});
        }
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: RenonColors.cream,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            automaticallyImplyLeading: false,
            expandedHeight: 72,
            toolbarHeight: 72,
            titleSpacing: 20,
            title: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: RenonColors.forest,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Center(
                    child: Text(
                      'R',
                      style: TextStyle(
                        color: RenonColors.lime,
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                const Text(
                  'RENON',
                  style: TextStyle(
                    color: RenonColors.ink,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const RiderNotificationsScreen(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: RenonColors.ink,
                  size: 27,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () {
                    _selectTab(3);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: RenonColors.smoke,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: RenonColors.line,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_rounded,
                      color: RenonColors.forest,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              20,
              14,
              20,
              30,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildGreeting(),
                const SizedBox(height: 20),
                _buildOnlineCard(),
                const SizedBox(height: 20),
                _buildStats(),
                const SizedBox(height: 28),
                _buildSectionHeader(),
                const SizedBox(height: 12),
                _buildDeliveryCard(
                  restaurant: 'Campus Bites',
                  pickup: 'Student Union Building',
                  dropoff: 'Block A, Campus Hostel',
                  distance: '1.8 km',
                  fee: '₦1,500',
                  time: '12 min',
                ),
                const SizedBox(height: 14),
                _buildDeliveryCard(
                  restaurant: 'Mama T’s Kitchen',
                  pickup: 'University Gate',
                  dropoff: 'Staff Quarters',
                  distance: '2.4 km',
                  fee: '₦2,000',
                  time: '18 min',
                ),
                const SizedBox(height: 14),
                _buildTodaySummary(),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greeting(),
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Samuel 👋',
          style: TextStyle(
            color: RenonColors.ink,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          _isOnline
              ? 'You’re online and ready for deliveries.'
              : 'You’re currently offline.',
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildOnlineCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _isOnline
            ? RenonColors.forest
            : RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: _isOnline
              ? Colors.transparent
              : RenonColors.line,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _isOnline
                  ? Colors.white.withValues(alpha: 0.12)
                  : RenonColors.smoke,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              _isOnline
                  ? Icons.bolt_rounded
                  : Icons.pause_rounded,
              color: _isOnline
                  ? RenonColors.lime
                  : RenonColors.muted,
              size: 26,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isOnline
                      ? 'You are online'
                      : 'You are offline',
                  style: TextStyle(
                    color: _isOnline
                        ? RenonColors.paper
                        : RenonColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _isOnline
                      ? 'Nearby delivery requests will appear here.'
                      : 'Go online to receive delivery requests.',
                  style: TextStyle(
                    color: _isOnline
                        ? Colors.white.withValues(alpha: 0.68)
                        : RenonColors.muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _isOnline,
            onChanged: (value) {
              setState(() {
                _isOnline = value;
              });

              _showMessage(
                value
                    ? 'You are now online'
                    : 'You are now offline',
              );
            },
            activeThumbColor: RenonColors.lime,
            activeTrackColor: RenonColors.palm,
          ),
        ],
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Today',
            value: '₦8,500',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.local_shipping_rounded,
            label: 'Deliveries',
            value: '7',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.star_rounded,
            label: 'Rating',
            value: '4.9',
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Available deliveries',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            _selectTab(1);
          },
          child: const Text(
            'See all',
            style: TextStyle(
              color: RenonColors.forest,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryCard({
    required String restaurant,
    required String pickup,
    required String dropoff,
    required String distance,
    required String fee,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: RenonColors.smoke,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: RenonColors.forest,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: RenonColors.ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$distance • $time away',
                      style: const TextStyle(
                        color: RenonColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                fee,
                style: const TextStyle(
                  color: RenonColors.forest,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _LocationRow(
            icon: Icons.radio_button_checked_rounded,
            label: 'Pickup',
            value: pickup,
          ),
          const SizedBox(height: 9),
          _LocationRow(
            icon: Icons.location_on_rounded,
            label: 'Drop-off',
            value: dropoff,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              onPressed: () {
                _showMessage(
                  'Delivery from $restaurant accepted',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RenonColors.forest,
                foregroundColor: RenonColors.paper,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Accept delivery',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: RenonColors.lime.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.insights_rounded,
                  color: RenonColors.forest,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Today’s progress',
                style: TextStyle(
                  color: RenonColors.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const LinearProgressIndicator(
              value: 0.7,
              minHeight: 9,
              backgroundColor: RenonColors.smoke,
              valueColor: AlwaysStoppedAnimation<Color>(
                RenonColors.palm,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(
                child: Text(
                  '7 deliveries completed',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '70%',
                style: TextStyle(
                  color: RenonColors.forest,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PROFILE
  // ============================================================

  Widget _buildProfilePage() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        children: [
          const Text(
            'Profile',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 22),

          // PROFILE CARD
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: RenonColors.paper,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: RenonColors.line,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 65,
                  decoration: const BoxDecoration(
                    color: RenonColors.forest,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: RenonColors.lime,
                    size: 34,
                  ),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Samuel',
                        style: TextStyle(
                          color: RenonColors.ink,
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'RENON Rider',
                        style: TextStyle(
                          color: RenonColors.muted,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 7),
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: RenonColors.gold,
                            size: 17,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '4.9 rating',
                            style: TextStyle(
                              color: RenonColors.forest,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: RenonColors.muted,
                ),
              ],
            ),
          ),

          const SizedBox(height: 26),

          // RIDER ACCOUNT
          const Text(
            'Rider account',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.directions_car_outlined,
            title: 'Vehicle information',
            subtitle: 'Manage your vehicle and documents',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiderVehicleScreen(),
                ),
              );
            },
          ),

          _ProfileOption(
            icon: Icons.verified_user_outlined,
            title: 'Verification',
            subtitle: 'Identity, licence and rider verification',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const RiderVerificationScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // APP
          const Text(
            'App',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.notifications_none_rounded,
            title: 'Notifications',
            subtitle: 'Delivery alerts, earnings and updates',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const RiderNotificationsScreen(),
                ),
              );
            },
          ),

          _ProfileOption(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'Account, privacy and app preferences',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiderSettingsScreen(),
                ),
              );
            },
          ),

          _ProfileOption(
            icon: Icons.help_outline_rounded,
            title: 'Help & support',
            subtitle: 'FAQs, support and report a problem',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const RiderHelpSupportScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // ACCOUNT
          const Text(
            'Account',
            style: TextStyle(
              color: RenonColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),

          _ProfileOption(
            icon: Icons.swap_horiz_rounded,
            title: 'Switch account',
            subtitle:
                'Sign in with a different RENON account',
            onTap: _showSwitchAccountDialog,
          ),

          const SizedBox(height: 4),

          // LOGOUT
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: RenonColors.paper,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(
                color: RenonColors.danger.withValues(alpha: 0.18),
              ),
            ),
            child: ListTile(
              onTap: _showLogoutDialog,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 3,
              ),
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color:
                      RenonColors.danger.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.logout_rounded,
                  color: RenonColors.danger,
                  size: 21,
                ),
              ),
              title: const Text(
                'Log out',
                style: TextStyle(
                  color: RenonColors.danger,
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                ),
              ),
              subtitle: const Text(
                'Sign out of your rider account',
                style: TextStyle(
                  color: RenonColors.muted,
                  fontSize: 11,
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: RenonColors.danger,
              ),
            ),
          ),

          const SizedBox(height: 26),

          // VERSION
          const Center(
            child: Column(
              children: [
                Text(
                  'RENON Rider',
                  style: TextStyle(
                    color: RenonColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: RenonColors.softText,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SWITCH ACCOUNT
  // ============================================================

  void _showSwitchAccountDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: RenonColors.paper,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Switch account?',
            style: TextStyle(
              color: RenonColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
          content: const Text(
            'Your current rider session will be cleared and you can choose another account type.',
            style: TextStyle(
              color: RenonColors.muted,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: RenonColors.muted,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                await AuthServiceScope.of(context).logout();

                if (!mounted) return;

                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.accountType,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RenonColors.forest,
                foregroundColor: RenonColors.paper,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: const Text(
                'Switch account',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // HELPERS
  // ============================================================

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning';
    }

    if (hour < 17) {
      return 'Good afternoon';
    }

    return 'Good evening';
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }
}

// ============================================================
// SMALL REUSABLE WIDGETS
// ============================================================

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: RenonColors.forest,
            size: 21,
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: RenonColors.ink,
              fontSize: 17,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: RenonColors.muted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  const _LocationRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 19,
          color: RenonColors.palm,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: RenonColors.softText,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: RenonColors.ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: RenonColors.paper,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: RenonColors.line,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 3,
        ),
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: RenonColors.smoke,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: RenonColors.forest,
            size: 21,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: RenonColors.ink,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: RenonColors.muted,
            fontSize: 11,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right_rounded,
          color: RenonColors.muted,
        ),
      ),
    );
  }
}