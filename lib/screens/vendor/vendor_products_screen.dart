
import 'package:flutter/material.dart';

import '../../app/app_routes.dart';
import '../../theme/renon_colors.dart';

class VendorProductsScreen extends StatefulWidget {
  const VendorProductsScreen({super.key});

  @override
  State<VendorProductsScreen> createState() => _VendorProductsScreenState();
}

class _VendorProductsScreenState extends State<VendorProductsScreen> {
  final List<_VendorProduct> _products = [];

  void _openProductForm({_VendorProduct? product}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: RenonColors.ink,
      builder: (context) {
        return _ProductFormSheet(
          product: product,
          onSave: (newProduct) {
            setState(() {
              if (product == null) {
                _products.add(newProduct);
              } else {
                final index = _products.indexOf(product);
                if (index != -1) {
                  _products[index] = newProduct;
                }
              }
            });

            Navigator.pop(context);

            ScaffoldMessenger.of(this.context).showSnackBar(
              SnackBar(
                content: Text(
                  product == null
                      ? 'Product added successfully.'
                      : 'Product updated successfully.',
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _deleteProduct(_VendorProduct product) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF171B17),
          title: const Text(
            'Delete product?',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete "${product.name}"?',
            style: const TextStyle(color: Color(0xFFB8BDB8)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _products.remove(product);
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product deleted.'),
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleAvailability(_VendorProduct product) {
    setState(() {
      product.isAvailable = !product.isAvailable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RenonColors.ink,

      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: RenonColors.ink,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Add product',
            onPressed: () => _openProductForm(),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),

      floatingActionButton: _products.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () => _openProductForm(),
              backgroundColor: RenonColors.palm,
              foregroundColor: RenonColors.ink,
              icon: const Icon(Icons.add_rounded),
              label: const Text(
                'Add product',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          child: _products.isEmpty
              ? _buildEmptyState()
              : _buildProductList(),
        ),
      ),

      // VENDOR NAVIGATION
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF111411),
        selectedIndex: 2,
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
            return;
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

  Widget _buildEmptyState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Manage the products customers can order from your store.',
          style: TextStyle(
            color: Color(0xFF858C85),
            fontSize: 14,
            height: 1.4,
          ),
        ),
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B201B),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      color: RenonColors.palm,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'No products yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add your first product to start selling\non Renon.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF777E77),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () => _openProductForm(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RenonColors.palm,
                        foregroundColor: RenonColors.ink,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text(
                        'Add product',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your products',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${_products.length} ${_products.length == 1 ? 'product' : 'products'} in your store',
          style: const TextStyle(
            color: Color(0xFF858C85),
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 90),
            itemCount: _products.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final product = _products[index];
              return _buildProductCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(_VendorProduct product) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF171B17),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF262C26),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              color: const Color(0xFF222822),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.image_outlined,
              color: Color(0xFF626A62),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      color: const Color(0xFF202520),
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        color: Color(0xFF8B928B),
                      ),
                      onSelected: (value) {
                        if (value == 'edit') {
                          _openProductForm(product: product);
                        } else if (value == 'delete') {
                          _deleteProduct(product);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_outlined,
                                color: Colors.white,
                                size: 19,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline_rounded,
                                color: Colors.redAccent,
                                size: 19,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: const TextStyle(
                    color: Color(0xFF858C85),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _formatPrice(product.price),
                  style: const TextStyle(
                    color: RenonColors.palm,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: product.isAvailable
                            ? RenonColors.palm
                            : Colors.redAccent,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      product.isAvailable
                          ? 'Available'
                          : 'Unavailable',
                      style: TextStyle(
                        color: product.isAvailable
                            ? RenonColors.palm
                            : Colors.redAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                      value: product.isAvailable,
                      onChanged: (_) =>
                          _toggleAvailability(product),
                      activeThumbColor: RenonColors.palm,
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

  String _formatPrice(double price) {
    final value = price.toStringAsFixed(0);

    final formatted = value.replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );

    return '₦$formatted';
  }
}

class _ProductFormSheet extends StatefulWidget {
  const _ProductFormSheet({
    required this.onSave,
    this.product,
  });

  final _VendorProduct? product;
  final ValueChanged<_VendorProduct> onSave;

  @override
  State<_ProductFormSheet> createState() => _ProductFormSheetState();
}

class _ProductFormSheetState extends State<_ProductFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;

  String _selectedCategory = 'Food';
  bool _isAvailable = true;

  final List<String> _categories = [
    'Food',
    'Drinks',
    'Fashion',
    'Electronics',
    'Beauty',
    'Groceries',
    'Services',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    _nameController = TextEditingController(
      text: product?.name ?? '',
    );

    _priceController = TextEditingController(
      text: product == null
          ? ''
          : product.price.toStringAsFixed(0),
    );

    _descriptionController = TextEditingController(
      text: product?.description ?? '',
    );

    if (product != null) {
      _selectedCategory = product.category;
      _isAvailable = product.isAvailable;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final price = double.tryParse(
      _priceController.text.trim().replaceAll(',', ''),
    );

    if (price == null) {
      return;
    }

    final product = _VendorProduct(
      name: _nameController.text.trim(),
      price: price,
      category: _selectedCategory,
      description: _descriptionController.text.trim(),
      isAvailable: _isAvailable,
    );

    widget.onSave(product);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF454B45),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  widget.product == null
                      ? 'Add product'
                      : 'Edit product',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Add the details customers need to see.',
                  style: TextStyle(
                    color: Color(0xFF858C85),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 24),

                _buildLabel('Product name'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: _inputDecoration(
                    'e.g. Jollof Rice',
                    Icons.shopping_bag_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a product name.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 17),

                _buildLabel('Price'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _priceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: _inputDecoration(
                    'e.g. 2500',
                    Icons.payments_outlined,
                    prefixText: '₦ ',
                  ),
                  validator: (value) {
                    final price = double.tryParse(
                      (value ?? '').trim().replaceAll(',', ''),
                    );

                    if (price == null || price <= 0) {
                      return 'Enter a valid price.';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 17),

                _buildLabel('Category'),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: _selectedCategory,
                  dropdownColor: const Color(0xFF202520),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: _inputDecoration(
                    'Select category',
                    Icons.category_outlined,
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    }
                  },
                ),

                const SizedBox(height: 17),

                _buildLabel('Description'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  minLines: 3,
                  maxLines: 5,
                  textCapitalization:
                      TextCapitalization.sentences,
                  decoration: _inputDecoration(
                    'Tell customers about this product...',
                    Icons.notes_outlined,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Add a short description.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF171B17),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: SwitchListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    title: const Text(
                      'Available for orders',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      _isAvailable
                          ? 'Customers can order this product.'
                          : 'Customers cannot order this product.',
                      style: const TextStyle(
                        color: Color(0xFF777E77),
                        fontSize: 12,
                      ),
                    ),
                    value: _isAvailable,
                    activeThumbColor: RenonColors.palm,
                    onChanged: (value) {
                      setState(() {
                        _isAvailable = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: RenonColors.palm,
                      foregroundColor: RenonColors.ink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      widget.product == null
                          ? 'Add product'
                          : 'Save changes',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    String? prefixText,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixText: prefixText,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xFF202520),
      hintStyle: const TextStyle(
        color: Color(0xFF626962),
      ),
      prefixStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w700,
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF2A302A),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: RenonColors.palm,
          width: 1.4,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Colors.redAccent,
        ),
      ),
    );
  }
}

class _VendorProduct {
  _VendorProduct({
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.isAvailable,
  });

  String name;
  double price;
  String category;
  String description;
  bool isAvailable;
}
