import 'package:flutter/material.dart';

import '../theme/renon_colors.dart';
import '../theme/renon_spacing.dart';

class FormErrorBanner extends StatelessWidget {
  const FormErrorBanner({
    super.key,
    required this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(RenonSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0x18D83B3B),
        borderRadius: BorderRadius.circular(RenonRadius.md),
        border: Border.all(color: const Color(0x38D83B3B)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: RenonColors.danger,
            size: 20,
          ),
          const SizedBox(width: RenonSpacing.sm),
          Expanded(
            child: Text(
              message!,
              style: const TextStyle(
                color: RenonColors.danger,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
