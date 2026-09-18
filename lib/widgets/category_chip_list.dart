import 'package:flutter/material.dart';

import '../models/marketplace_category.dart';
import '../theme/renon_colors.dart';
import '../theme/renon_spacing.dart';

class CategoryChipList extends StatelessWidget {
  const CategoryChipList({
    super.key,
    required this.categories,
    this.selectedCategory,
    this.onSelected,
    this.includeAll = false,
  });

  final List<MarketplaceCategory> categories;
  final String? selectedCategory;
  final ValueChanged<String?>? onSelected;
  final bool includeAll;

  @override
  Widget build(BuildContext context) {
    final chips = [
      if (includeAll)
        _CategoryOption(
          label: 'All',
          icon: Icons.grid_view_rounded,
          value: null,
        ),
      ...categories.map(
        (category) => _CategoryOption(
          label: category.name,
          icon: category.icon,
          value: category.name,
        ),
      ),
    ];

    return SizedBox(
      height: 96,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, _) => const SizedBox(width: RenonSpacing.sm),
        itemBuilder: (context, index) {
          final chip = chips[index];
          final isSelected = selectedCategory == chip.value;
          return ChoiceChip(
            selected: isSelected,
            onSelected: (_) => onSelected?.call(chip.value),
            showCheckmark: false,
            avatar: Icon(
              chip.icon,
              size: 18,
              color: isSelected ? RenonColors.ink : RenonColors.palm,
            ),
            label: Text(chip.label),
          );
        },
      ),
    );
  }
}

class _CategoryOption {
  const _CategoryOption({
    required this.label,
    required this.icon,
    required this.value,
  });

  final String label;
  final IconData icon;
  final String? value;
}
