import 'package:flutter/material.dart';

import '../theme/renon_colors.dart';

class MarketplaceSectionHeader extends StatelessWidget {
  const MarketplaceSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onActionPressed,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionLabel!,
              style: const TextStyle(
                color: RenonColors.palm,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
      ],
    );
  }
}
