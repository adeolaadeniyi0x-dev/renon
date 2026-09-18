import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/product.dart';
import '../../models/vendor.dart';
import '../../services/mock_marketplace_service.dart';
import '../../theme/renon_spacing.dart';
import '../../widgets/category_chip_list.dart';
import '../../widgets/marketplace_search_bar.dart';
import '../../widgets/marketplace_section_header.dart';
import '../../widgets/marketplace_state.dart';
import '../../widgets/product_card.dart';
import '../../widgets/vendor_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _marketplaceService = const MockMarketplaceService();
  final _searchController = TextEditingController();

  String _query = '';
  String? _selectedCategory;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Vendor> get _vendors {
    return _marketplaceService.searchVendors(
      query: _query,
      category: _selectedCategory,
    );
  }

  List<Product> get _products {
    return _marketplaceService.searchProducts(
      query: _query,
      category: _selectedCategory,
    );
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
    final vendors = _vendors;
    final products = _products;
    final hasResults = vendors.isNotEmpty || products.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Search Renon')),
      body: SafeArea(
        top: false,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(
            RenonSpacing.lg,
            RenonSpacing.md,
            RenonSpacing.lg,
            MediaQuery.viewInsetsOf(context).bottom + RenonSpacing.xl,
          ),
          children: [
            MarketplaceSearchBar(
              controller: _searchController,
              autofocus: true,
              onChanged: (value) => setState(() => _query = value),
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
              child: hasResults
                  ? _SearchResults(
                      key: ValueKey('$_query-$_selectedCategory'),
                      vendors: vendors,
                      products: products,
                      onVendorTap: _openVendor,
                    )
                  : const MarketplaceEmptyState(
                      title: 'Nothing matched that search',
                      message: 'Try food, laundry, groceries, stationery or a campus location.',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({
    super.key,
    required this.vendors,
    required this.products,
    required this.onVendorTap,
  });

  final List<Vendor> vendors;
  final List<Product> products;
  final ValueChanged<Vendor> onVendorTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vendors.isNotEmpty) ...[
          const MarketplaceSectionHeader(title: 'Vendors'),
          const SizedBox(height: RenonSpacing.sm),
          ...vendors.map(
            (vendor) => Padding(
              padding: const EdgeInsets.only(bottom: RenonSpacing.md),
              child: VendorCard(
                vendor: vendor,
                onTap: () => onVendorTap(vendor),
              ),
            ),
          ),
        ],
        if (products.isNotEmpty) ...[
          const SizedBox(height: RenonSpacing.md),
          const MarketplaceSectionHeader(title: 'Products'),
          const SizedBox(height: RenonSpacing.sm),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 560;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isWide ? 2 : 1,
                  mainAxisSpacing: RenonSpacing.md,
                  crossAxisSpacing: RenonSpacing.md,
                  childAspectRatio: isWide ? 0.78 : 0.92,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              );
            },
          ),
        ],
      ],
    );
  }
}
