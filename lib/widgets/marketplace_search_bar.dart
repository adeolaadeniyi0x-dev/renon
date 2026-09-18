import 'package:flutter/material.dart';

class MarketplaceSearchBar extends StatelessWidget {
  const MarketplaceSearchBar({
    super.key,
    this.controller,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.autofocus = false,
    this.hintText = 'Search food, vendors, laundry...',
  });

  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final bool autofocus;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
      autofocus: autofocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: controller != null && controller!.text.isNotEmpty
            ? IconButton(
                tooltip: 'Clear search',
                onPressed: () {
                  controller!.clear();
                  onChanged?.call('');
                },
                icon: const Icon(Icons.close_rounded),
              )
            : null,
      ),
    );
  }
}
