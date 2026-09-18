
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../theme/renon_colors.dart';
import '../theme/renon_spacing.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
  });

  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(RenonSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              AspectRatio(
                aspectRatio: 1.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(RenonRadius.md),
                  child: product.imageUrl.isNotEmpty
                      ? Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildImagePlaceholder();
                          },
                        )
                      : _buildImagePlaceholder(),
                ),
              ),

              const SizedBox(height: RenonSpacing.md),

              // Product name
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: RenonSpacing.xs),

              // Description
              Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  height: 1.35,
                ),
              ),

              const SizedBox(height: RenonSpacing.sm),

              // Category
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: RenonColors.smoke,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  product.category,
                  style: const TextStyle(
                    color: RenonColors.palm,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              const SizedBox(height: RenonSpacing.sm),

              // Vendor + price
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      product.vendorName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: RenonSpacing.sm),
                  Text(
                    '₦${_formatPrice(product.price)}',
                    style: const TextStyle(
                      color: RenonColors.palm,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: RenonColors.smoke,
      child: const Center(
        child: Icon(
          Icons.shopping_bag_rounded,
          color: RenonColors.palm,
          size: 36,
        ),
      ),
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)},',
    );
  }
}

