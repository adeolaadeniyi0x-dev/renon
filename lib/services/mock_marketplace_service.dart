
import 'package:flutter/material.dart';

import '../models/marketplace_category.dart';
import '../models/marketplace_snapshot.dart';
import '../models/product.dart';
import '../models/vendor.dart';

class MockMarketplaceService {
  const MockMarketplaceService();

  Future<MarketplaceSnapshot> getHomeSnapshot() async {
    await Future<void>.delayed(const Duration(milliseconds: 450));

    return MarketplaceSnapshot(
      categories: getCategories(),
      featuredVendors: getFeaturedVendors(),
      popularProducts: getPopularProducts(),
      nearbyVendors: getNearbyVendors(),
    );
  }

  List<MarketplaceCategory> getCategories() => const [
        MarketplaceCategory(
          name: 'Food',
          icon: Icons.restaurant_rounded,
        ),
        MarketplaceCategory(
          name: 'Groceries',
          icon: Icons.local_grocery_store_rounded,
        ),
        MarketplaceCategory(
          name: 'Fashion',
          icon: Icons.checkroom_rounded,
        ),
        MarketplaceCategory(
          name: 'Beauty',
          icon: Icons.spa_rounded,
        ),
        MarketplaceCategory(
          name: 'Electronics',
          icon: Icons.devices_rounded,
        ),
        MarketplaceCategory(
          name: 'Stationery',
          icon: Icons.edit_note_rounded,
        ),
        MarketplaceCategory(
          name: 'Laundry',
          icon: Icons.local_laundry_service_rounded,
        ),
        MarketplaceCategory(
          name: 'Services',
          icon: Icons.handyman_rounded,
        ),
        MarketplaceCategory(
          name: 'Campus',
          icon: Icons.school_rounded,
        ),
      ];

  List<Vendor> getVendors() => const [
        Vendor(
          id: 'vendor-1',
          name: 'Campus Bites',
          category: 'Food',
          rating: 4.8,
          deliveryTime: '20-30 min',
          location: 'University of Lagos',
          deliveryFee: 600,
          tags: ['Jollof', 'Chicken', 'Late night'],
          isFeatured: true,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-2',
          name: 'Fresh Errands',
          category: 'Services',
          rating: 4.6,
          deliveryTime: '35-45 min',
          location: 'Yaba',
          deliveryFee: 800,
          tags: ['Pickup', 'Dropoff', 'Same day'],
          isFeatured: true,
          imageUrl:
              'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-3',
          name: 'Mama Nkechi Groceries',
          category: 'Groceries',
          rating: 4.7,
          deliveryTime: '25-40 min',
          location: 'Akoka',
          deliveryFee: 700,
          tags: ['Tomatoes', 'Rice', 'Provisions'],
          isFeatured: true,
          imageUrl:
              'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-4',
          name: 'Zara Thrift Hub',
          category: 'Fashion',
          rating: 4.5,
          deliveryTime: '45-60 min',
          location: 'Yaba Market',
          deliveryFee: 1000,
          tags: ['Thrift', 'Sneakers', 'Streetwear'],
          isFeatured: false,
          imageUrl:
              'https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-5',
          name: 'Glow Room Beauty',
          category: 'Beauty',
          rating: 4.9,
          deliveryTime: '30-45 min',
          location: 'Surulere',
          deliveryFee: 900,
          tags: ['Skincare', 'Wigs', 'Makeup'],
          isFeatured: false,
          imageUrl:
              'https://images.unsplash.com/photo-1596462502278-27bfdc403348?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-6',
          name: 'Tech Plug NG',
          category: 'Electronics',
          rating: 4.4,
          deliveryTime: '50-70 min',
          location: 'Computer Village',
          deliveryFee: 1200,
          tags: ['Chargers', 'Earbuds', 'Repairs'],
          isFeatured: false,
          imageUrl:
              'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-7',
          name: 'Sharp Notes Stationery',
          category: 'Stationery',
          rating: 4.6,
          deliveryTime: '20-35 min',
          location: 'Unilag Gate',
          deliveryFee: 500,
          tags: ['Handouts', 'Printing', 'Notebooks'],
          isFeatured: false,
          imageUrl:
              'https://images.unsplash.com/photo-1456324504439-367cee3b3c32?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-8',
          name: 'Washday Campus Laundry',
          category: 'Laundry',
          rating: 4.7,
          deliveryTime: '24 hrs',
          location: 'Moremi Hall',
          deliveryFee: 500,
          tags: ['Pickup', 'Ironing', 'Express'],
          isFeatured: true,
          imageUrl:
              'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?auto=format&fit=crop&w=900&q=85',
        ),
        Vendor(
          id: 'vendor-9',
          name: 'Hall Connect',
          category: 'Campus',
          rating: 4.5,
          deliveryTime: '15-25 min',
          location: 'Jaja Hall',
          deliveryFee: 400,
          tags: ['Hostel items', 'Water', 'Quick runs'],
          isFeatured: false,
          imageUrl:
              'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?auto=format&fit=crop&w=900&q=85',
        ),
      ];

  List<Vendor> getFeaturedVendors() {
    return getVendors()
        .where((vendor) => vendor.isFeatured)
        .toList();
  }

  List<Vendor> getNearbyVendors() {
    return getVendors()
        .where(
          (vendor) =>
              vendor.location.contains('Unilag') ||
              vendor.location.contains('University'),
        )
        .toList();
  }

  List<Product> getPopularProducts() => const [
        Product(
          id: 'product-1',
          vendorId: 'vendor-1',
          vendorName: 'Campus Bites',
          category: 'Food',
          name: 'Jollof Rice Bowl',
          description:
              'Smoky party-style jollof with chicken and plantain.',
          price: 3500,
          imageUrl:
              'https://images.unsplash.com/photo-1603133872878-684f208fb84b?auto=format&fit=crop&w=900&q=85',
        ),
        Product(
          id: 'product-2',
          vendorId: 'vendor-8',
          vendorName: 'Washday Campus Laundry',
          category: 'Laundry',
          name: 'Laundry Pickup',
          description:
              'Wash, fold and pickup support around campus hostels.',
          price: 2500,
          imageUrl:
              'https://images.unsplash.com/photo-1517677208171-0bc6725a3e60?auto=format&fit=crop&w=900&q=85',
        ),
        Product(
          id: 'product-3',
          vendorId: 'vendor-3',
          vendorName: 'Mama Nkechi Groceries',
          category: 'Groceries',
          name: 'Student Soup Pack',
          description:
              'Pepper, tomatoes, onions and seasoning starter pack.',
          price: 4200,
          imageUrl:
              'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=85',
        ),
        Product(
          id: 'product-4',
          vendorId: 'vendor-7',
          vendorName: 'Sharp Notes Stationery',
          category: 'Stationery',
          name: 'Exam Prep Bundle',
          description:
              'Notebooks, pens, sticky notes and highlighters.',
          price: 3100,
          imageUrl:
              'https://images.unsplash.com/photo-1517842645767-c639042777db?auto=format&fit=crop&w=900&q=85',
        ),
        Product(
          id: 'product-5',
          vendorId: 'vendor-9',
          vendorName: 'Hall Connect',
          category: 'Campus',
          name: 'Hostel Essentials Run',
          description:
              'Water, snacks and small hostel items delivered fast.',
          price: 1800,
          imageUrl:
              'https://images.unsplash.com/photo-1601598851547-4302969d0e8f?auto=format&fit=crop&w=900&q=85',
        ),
      ];

  List<Vendor> searchVendors({
    String query = '',
    String? category,
  }) {
    return getVendors().where((vendor) {
      final normalizedQuery = query.trim().toLowerCase();

      final matchesQuery = normalizedQuery.isEmpty ||
          vendor.name.toLowerCase().contains(normalizedQuery) ||
          vendor.category.toLowerCase().contains(normalizedQuery) ||
          vendor.location.toLowerCase().contains(normalizedQuery) ||
          vendor.tags.any(
            (tag) => tag.toLowerCase().contains(normalizedQuery),
          );

      final matchesCategory =
          category == null || vendor.category == category;

      return matchesQuery && matchesCategory;
    }).toList();
  }

  List<Product> searchProducts({
    String query = '',
    String? category,
  }) {
    return getPopularProducts().where((product) {
      final normalizedQuery = query.trim().toLowerCase();

      final matchesQuery = normalizedQuery.isEmpty ||
          product.name.toLowerCase().contains(normalizedQuery) ||
          product.description.toLowerCase().contains(normalizedQuery) ||
          product.vendorName.toLowerCase().contains(normalizedQuery);

      final matchesCategory =
          category == null || product.category == category;

      return matchesQuery && matchesCategory;
    }).toList();
  }
}

