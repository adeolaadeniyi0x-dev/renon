
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../theme/renon_colors.dart';

class VendorOrdersScreen extends StatelessWidget {
  const VendorOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.ink,

      appBar: AppBar(
        title: const Text('Orders'),
        backgroundColor: RenonColors.ink,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B201B),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Icon(
                    Icons.receipt_long_outlined,
                    color: RenonColors.palm,
                    size: 34,
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  'No orders yet',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'When customers place orders, they will appear here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF777E77),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // VENDOR NAVIGATION
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111411),
        selectedIndex: 1,
        indicatorColor: RenonColors.palm.withValues(alpha: 0.18),

        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.vendorHome,
            );
          }

          if (index == 1) {
            return;
          }

          if (index == 2) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.vendorProducts,
            );
          }

          if (index == 3) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.vendorStore,
            );
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
}
