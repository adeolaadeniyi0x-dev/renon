import 'package:flutter/material.dart';

import '../theme/renon_colors.dart';
import '../theme/renon_spacing.dart';

class MarketplaceLoadingState extends StatelessWidget {
  const MarketplaceLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(RenonSpacing.xl),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MarketplaceEmptyState extends StatelessWidget {
  const MarketplaceEmptyState({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(RenonSpacing.lg),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              color: RenonColors.palm,
              size: 34,
            ),
            const SizedBox(height: RenonSpacing.md),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: RenonSpacing.xs),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
