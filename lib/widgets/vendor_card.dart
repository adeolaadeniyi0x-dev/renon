import 'package:flutter/material.dart';

import '../models/vendor.dart';
import '../theme/renon_colors.dart';
import '../theme/renon_spacing.dart';

class VendorCard extends StatelessWidget {
  const VendorCard({
    super.key,
    required this.vendor,
    this.onTap,
  });

  final Vendor vendor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(RenonSpacing.md),
          child: Row(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: RenonColors.smoke,
                  borderRadius: BorderRadius.circular(RenonRadius.md),
                ),
                child: const Icon(
                  Icons.storefront_rounded,
                  color: RenonColors.palm,
                ),
              ),
              const SizedBox(width: RenonSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: RenonSpacing.xxs),
                    Text(
                      '${vendor.category} - ${vendor.location}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: RenonSpacing.xs),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: RenonColors.gold,
                        ),
                        const SizedBox(width: RenonSpacing.xxs),
                        Text(
                          vendor.rating.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(width: RenonSpacing.sm),
                        Text(vendor.deliveryTime),
                        const SizedBox(width: RenonSpacing.sm),
                        Expanded(
                          child: Text(
                            'NGN ${vendor.deliveryFee} delivery',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
