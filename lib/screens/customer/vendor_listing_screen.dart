import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/vendor.dart';
import '../../services/mock_marketplace_service.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/category_chip_list.dart';
import '../../widgets/marketplace_state.dart';
import '../../widgets/vendor_card.dart';

class VendorListingScreen extends StatefulWidget {
  const VendorListingScreen({super.key});

  @override
  State<VendorListingScreen> createState() => _VendorListingScreenState();
}

class _VendorListingScreenState extends State<VendorListingScreen> {
  final _marketplaceService = const MockMarketplaceService();
  String? _selectedCategory;
  bool _didReadArgs = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didReadArgs) return;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _selectedCategory = args;
    }
    _didReadArgs = true;
  }

  void _openVendor(Vendor vendor) {
    Navigator.pushNamed(
      context,
      AppRoutes.vendorStore,
      arguments: vendor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final vendors = _marketplaceService.searchVendors(
      category: _selectedCategory,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Vendors')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            RenonSpacing.lg,
            RenonSpacing.md,
            RenonSpacing.lg,
            RenonSpacing.xl,
          ),
          children: [
            Text(
              'Explore trusted stores around your campus and city.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: RenonSpacing.lg),
            CategoryChipList(
              categories: _marketplaceService.getCategories(),
              includeAll: true,
              selectedCategory: _selectedCategory,
              onSelected: (category) {
                setState(() => _selectedCategory = category);
              },
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: vendors.isEmpty
                  ? const MarketplaceEmptyState(
                      title: 'No vendors here yet',
                      message: 'Try another category while Renon grows this area.',
                    )
                  : Column(
                      key: ValueKey(_selectedCategory ?? 'all-vendors'),
                      children: vendors
                          .map(
                            (vendor) => Padding(
                              padding: const EdgeInsets.only(
                                bottom: RenonSpacing.md,
                              ),
                              child: VendorCard(
                                vendor: vendor,
                                onTap: () => _openVendor(vendor),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
