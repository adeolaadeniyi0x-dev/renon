
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../models/vendor.dart';
import '../../theme/renon_colors.dart';
import '../../theme/renon_spacing.dart';

class VendorStorePlaceholderScreen extends StatefulWidget {
  const VendorStorePlaceholderScreen({super.key});

  @override
  State<VendorStorePlaceholderScreen> createState() =>
      _VendorStorePlaceholderScreenState();
}

class _VendorStorePlaceholderScreenState
    extends State<VendorStorePlaceholderScreen> {
  bool _isStoreOnline = true;
  bool _deliveryAvailable = true;

  String _storeName = 'Your Store';
  String _description =
      'Tell customers a little about your business and what you offer.';
  String _category = 'Food & Drinks';
  String _location = 'Your business location';
  String _openingTime = '8:00 AM';
  String _closingTime = '10:00 PM';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final vendor = args is Vendor ? args : null;

    if (vendor != null && _storeName == 'Your Store') {
      _storeName = vendor.name;
      _category = vendor.category;
      _location = vendor.location;
    }

    return Scaffold(
      backgroundColor: RenonColors.ink,

      appBar: AppBar(
        backgroundColor: RenonColors.ink,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Manage Store',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            RenonSpacing.lg,
            RenonSpacing.sm,
            RenonSpacing.lg,
            30,
          ),
          children: [
            _buildStoreHeader(),
            const SizedBox(height: 20),

            _buildSectionTitle('Store status'),
            const SizedBox(height: 10),
            _buildStatusCard(),
            const SizedBox(height: 28),

            _buildSectionTitle('Store information'),
            const SizedBox(height: 10),

            _buildInfoTile(
              icon: Icons.storefront_outlined,
              title: 'Store name',
              value: _storeName,
              onTap: () => _editField(
                title: 'Store name',
                initialValue: _storeName,
                onSave: (value) {
                  setState(() => _storeName = value);
                },
              ),
            ),

            _buildInfoTile(
              icon: Icons.category_outlined,
              title: 'Category',
              value: _category,
              onTap: _showCategoryPicker,
            ),

            _buildInfoTile(
              icon: Icons.location_on_outlined,
              title: 'Location',
              value: _location,
              onTap: () => _editField(
                title: 'Business location',
                initialValue: _location,
                onSave: (value) {
                  setState(() => _location = value);
                },
              ),
            ),

            _buildInfoTile(
              icon: Icons.description_outlined,
              title: 'Description',
              value: _description,
              onTap: () => _editField(
                title: 'Store description',
                initialValue: _description,
                maxLines: 4,
                onSave: (value) {
                  setState(() => _description = value);
                },
              ),
            ),

            const SizedBox(height: 28),

            _buildSectionTitle('Delivery'),
            const SizedBox(height: 10),
            _buildDeliveryCard(),

            const SizedBox(height: 28),

            _buildSectionTitle('Opening hours'),
            const SizedBox(height: 10),
            _buildHoursCard(),

            const SizedBox(height: 30),

            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Store information saved locally.',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: RenonColors.palm,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Save changes',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            // Extra space so the last content isn't hidden
            // behind the bottom navigation.
            const SizedBox(height: 20),
          ],
        ),
      ),

      // VENDOR NAVIGATION
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111411),
        selectedIndex: 3,
        indicatorColor: RenonColors.palm.withValues(alpha: 0.18),

        onDestinationSelected: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.vendorHome,
            );
          }

          if (index == 1) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.vendorOrders,
            );
          }

          if (index == 2) {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.vendorProducts,
            );
          }

          if (index == 3) {
            return;
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

  Widget _buildStoreHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
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
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: RenonColors.palm.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.storefront_rounded,
              color: RenonColors.palm,
              size: 36,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _storeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _category,
                  style: const TextStyle(
                    color: Color(0xFF777E77),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: _isStoreOnline
                          ? RenonColors.palm
                          : const Color(0xFF777E77),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isStoreOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                        color: _isStoreOnline
                            ? RenonColors.palm
                            : const Color(0xFF777E77),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B201B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF2B312B),
        ),
      ),
      child: SwitchListTile(
        value: _isStoreOnline,
        activeThumbColor: RenonColors.palm,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        secondary: const Icon(
          Icons.storefront_outlined,
          color: RenonColors.palm,
        ),
        title: const Text(
          'Store online',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          _isStoreOnline
              ? 'Customers can currently place orders.'
              : 'Customers cannot currently place orders.',
          style: const TextStyle(
            color: Color(0xFF777E77),
            fontSize: 12,
          ),
        ),
        onChanged: (value) {
          setState(() => _isStoreOnline = value);
        },
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B201B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF2B312B),
        ),
      ),
      child: SwitchListTile(
        value: _deliveryAvailable,
        activeThumbColor: RenonColors.palm,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        secondary: const Icon(
          Icons.delivery_dining_rounded,
          color: RenonColors.palm,
        ),
        title: const Text(
          'Delivery available',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          _deliveryAvailable
              ? 'Customers can request delivery.'
              : 'Delivery is currently unavailable.',
          style: const TextStyle(
            color: Color(0xFF777E77),
            fontSize: 12,
          ),
        ),
        onChanged: (value) {
          setState(() => _deliveryAvailable = value);
        },
      ),
    );
  }

  Widget _buildHoursCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B201B),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF2B312B),
        ),
      ),
      child: Column(
        children: [
          _buildHourTile(
            icon: Icons.login_rounded,
            title: 'Opening time',
            value: _openingTime,
            onTap: () => _pickTime(
              initial: _openingTime,
              onSelected: (value) {
                setState(() => _openingTime = value);
              },
            ),
          ),
          const Divider(
            color: Color(0xFF2B312B),
            height: 1,
          ),
          _buildHourTile(
            icon: Icons.logout_rounded,
            title: 'Closing time',
            value: _closingTime,
            onTap: () => _pickTime(
              initial: _closingTime,
              onSelected: (value) {
                setState(() => _closingTime = value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHourTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: Icon(
        icon,
        color: RenonColors.palm,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        value,
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

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1B201B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2B312B),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        leading: Icon(
          icon,
          color: RenonColors.palm,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF777E77),
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.edit_outlined,
          color: Color(0xFF626962),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 19,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  void _editField({
    required String title,
    required String initialValue,
    required ValueChanged<String> onSave,
    int maxLines = 1,
  }) {
    final controller = TextEditingController(
      text: initialValue,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B201B),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          content: TextField(
            controller: controller,
            maxLines: maxLines,
            autofocus: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF111411),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final value = controller.text.trim();

                if (value.isNotEmpty) {
                  onSave(value);
                }

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: RenonColors.palm,
              ),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showCategoryPicker() {
    const categories = [
      'Food & Drinks',
      'Fashion',
      'Electronics',
      'Beauty',
      'Groceries',
      'Services',
      'Health',
      'Other',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF171B17),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(26),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              25,
            ),
            children: [
              const Text(
                'Choose category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 15),
              ...categories.map(
                (category) => ListTile(
                  title: Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  trailing: category == _category
                      ? const Icon(
                          Icons.check_rounded,
                          color: RenonColors.palm,
                        )
                      : null,
                  onTap: () {
                    setState(() => _category = category);
                    Navigator.pop(sheetContext);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickTime({
    required String initial,
    required ValueChanged<String> onSelected,
  }) async {
    final parsed = _parseTime(initial);

    final picked = await showTimePicker(
      context: context,
      initialTime: parsed,
    );

    if (picked == null) return;

    final hour = picked.hourOfPeriod == 0
        ? 12
        : picked.hourOfPeriod;

    final minute = picked.minute.toString().padLeft(2, '0');
    final period = picked.period == DayPeriod.am
        ? 'AM'
        : 'PM';

    onSelected('$hour:$minute $period');
  }

  TimeOfDay _parseTime(String value) {
    final parts = value.split(' ');
    final time = parts.first.split(':');

    if (time.length != 2) {
      return const TimeOfDay(
        hour: 8,
        minute: 0,
      );
    }

    var hour = int.tryParse(time[0]) ?? 8;
    final minute = int.tryParse(time[1]) ?? 0;

    if (parts.length > 1 &&
        parts[1].toUpperCase() == 'PM' &&
        hour != 12) {
      hour += 12;
    }

    if (parts.length > 1 &&
        parts[1].toUpperCase() == 'AM' &&
        hour == 12) {
      hour = 0;
    }

    return TimeOfDay(
      hour: hour.clamp(0, 23),
      minute: minute.clamp(0, 59),
    );
  }
}

