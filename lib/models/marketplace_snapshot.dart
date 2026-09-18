import 'marketplace_category.dart';
import 'product.dart';
import 'vendor.dart';

class MarketplaceSnapshot {
  const MarketplaceSnapshot({
    required this.categories,
    required this.featuredVendors,
    required this.popularProducts,
    required this.nearbyVendors,
  });

  final List<MarketplaceCategory> categories;
  final List<Vendor> featuredVendors;
  final List<Product> popularProducts;
  final List<Vendor> nearbyVendors;
}
