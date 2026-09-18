
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/marketplace_snapshot.dart';
import '../../models/vendor.dart';
import '../../services/auth_service_scope.dart';
import '../../services/mock_marketplace_service.dart';
import '../../theme/renon_colors.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/category_chip_list.dart';
import '../../widgets/marketplace_search_bar.dart';
import '../../widgets/marketplace_section_header.dart';
import '../../widgets/marketplace_state.dart';
import '../../widgets/product_card.dart';
import '../../widgets/renon_logo.dart';
import '../../widgets/vendor_card.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final _marketplaceService = const MockMarketplaceService();
  late final Future<MarketplaceSnapshot> _snapshotFuture;

  @override
  void initState() {
    super.initState();
    _snapshotFuture = _marketplaceService.getHomeSnapshot();
  }

  void _openSearch() {
    Navigator.pushNamed(context, AppRoutes.search);
  }

  void _openVendorListing({String? category}) {
    Navigator.pushNamed(
      context,
      AppRoutes.vendorListing,
      arguments: category,
    );
  }

  void _openVendor(Vendor vendor) {
    Navigator.pushNamed(
      context,
      AppRoutes.vendorStore,
      arguments: vendor,
    );
  }

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
            'Are you sure you want to log out of your Renon account?',
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

  void _openAccountMenu() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: RenonColors.ink,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              RenonSpacing.lg,
              8,
              RenonSpacing.lg,
              RenonSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Manage your Renon account.',
                  style: TextStyle(
                    color: RenonColors.softText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                _AccountMenuTile(
                  icon: Icons.person_outline_rounded,
                  title: 'My profile',
                  subtitle: 'View and edit your personal information',
                  onTap: () {
                    Navigator.pop(context);

                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Profile management will be available soon.',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                _AccountMenuTile(
                  icon: Icons.swap_horiz_rounded,
                  title: 'Switch account',
                  subtitle: 'Use Renon as another account type',
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamedAndRemoveUntil(
                      this.context,
                      AppRoutes.accountType,
                      (route) => false,
                      arguments: {
                        'mode': 'switch',
                        'currentAccountType': 'Customer',
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                _AccountMenuTile(
                  icon: Icons.logout_rounded,
                  title: 'Log out',
                  subtitle: 'Sign out of this account',
                  destructive: true,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<MarketplaceSnapshot>(
          future: _snapshotFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const MarketplaceLoadingState();
            }

            final data = snapshot.data;
            if (data == null) {
              return const Padding(
                padding: EdgeInsets.all(RenonSpacing.lg),
                child: MarketplaceEmptyState(
                  title: 'Marketplace is warming up',
                  message: 'Please check again in a moment.',
                ),
              );
            }

            return ListView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                RenonSpacing.lg,
                RenonSpacing.md,
                RenonSpacing.lg,
                RenonSpacing.xl,
              ),
              children: [
                _HomeHeader(
                  onAccountTap: _openAccountMenu,
                ),
                const SizedBox(height: RenonSpacing.lg),
                MarketplaceSearchBar(
                  readOnly: true,
                  onTap: _openSearch,
                ),
                const SizedBox(height: RenonSpacing.xl),
                MarketplaceSectionHeader(
                  title: 'Categories',
                  actionLabel: 'View all',
                  onActionPressed: () => _openVendorListing(),
                ),
                const SizedBox(height: RenonSpacing.sm),
                CategoryChipList(
                  categories: data.categories,
                  onSelected: (category) =>
                      _openVendorListing(category: category),
                ),
                const SizedBox(height: RenonSpacing.xl),
                MarketplaceSectionHeader(
                  title: 'Featured vendors',
                  actionLabel: 'See all',
                  onActionPressed: () => _openVendorListing(),
                ),
                const SizedBox(height: RenonSpacing.sm),
                _VendorRail(
                  vendors: data.featuredVendors,
                  onVendorTap: _openVendor,
                ),
                const SizedBox(height: RenonSpacing.xl),
                const MarketplaceSectionHeader(
                  title: 'Popular products',
                ),
                const SizedBox(height: RenonSpacing.sm),
                SizedBox(
                  height: 306,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.popularProducts.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(width: RenonSpacing.md),
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 220,
                        child: ProductCard(
                          product: data.popularProducts[index],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: RenonSpacing.xl),
                MarketplaceSectionHeader(
                  title: 'Nearby vendors',
                  actionLabel: 'Explore',
                  onActionPressed: () => _openVendorListing(),
                ),
                const SizedBox(height: RenonSpacing.sm),
                if (data.nearbyVendors.isEmpty)
                  const MarketplaceEmptyState(
                    title: 'No nearby vendors yet',
                    message:
                        'Renon is adding more local stores around you.',
                  )
                else
                  ...data.nearbyVendors.map(
                    (vendor) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: RenonSpacing.md,
                      ),
                      child: VendorCard(
                        vendor: vendor,
                        onTap: () => _openVendor(vendor),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) _openSearch();
          if (index == 2) _openVendorListing();
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: 'Vendors',
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.onAccountTap,
  });

  final VoidCallback onAccountTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const RenonLogo(size: 48),
        const SizedBox(width: RenonSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good afternoon, Ire',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: RenonSpacing.xs),
              const Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: RenonColors.palm,
                    size: 18,
                  ),
                  SizedBox(width: RenonSpacing.xxs),
                  Expanded(
                    child: Text(
                      'University of Lagos, Akoka',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onAccountTap,
          tooltip: 'Account',
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
        ),
      ],
    );
  }
}

class _AccountMenuTile extends StatelessWidget {
  const _AccountMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.destructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive
        ? const Color(0xFFE57373)
        : Colors.white;

    return Material(
      color: const Color(0xFF202520),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: destructive
                      ? const Color(0xFFE57373).withValues(alpha: 0.10)
                      : const Color(0xFFC6F135).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: destructive
                      ? const Color(0xFFE57373)
                      : const Color(0xFFC6F135),
                  size: 22,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: color,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF858C86),
                        fontSize: 12,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF686E69),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorRail extends StatelessWidget {
  const _VendorRail({
    required this.vendors,
    required this.onVendorTap,
  });

  final List<Vendor> vendors;
  final ValueChanged<Vendor> onVendorTap;

  @override
  Widget build(BuildContext context) {
    if (vendors.isEmpty) {
      return const MarketplaceEmptyState(
        title: 'No featured vendors',
        message: 'Featured Renon vendors will appear here soon.',
      );
    }

    return SizedBox(
      height: 164,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: vendors.length,
        separatorBuilder: (_, _) =>
            const SizedBox(width: RenonSpacing.md),
        itemBuilder: (context, index) {
          final vendor = vendors[index];

          return SizedBox(
            width: 284,
            child: VendorCard(
              vendor: vendor,
              onTap: () => onVendorTap(vendor),
            ),
          );
        },
      ),
    );
  }
}

