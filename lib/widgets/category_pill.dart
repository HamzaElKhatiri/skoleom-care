import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CategoryPill extends StatelessWidget {
  const CategoryPill({super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        selected: selected,
        label: Text(label),
        onSelected: (_) => onTap(),
        showCheckmark: false,
        selectedColor: AppTheme.ink,
        backgroundColor: Colors.white.withOpacity(0.78),
        labelStyle: TextStyle(color: selected ? Colors.white : AppTheme.ink, fontWeight: FontWeight.w800),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999), side: BorderSide(color: selected ? AppTheme.ink : AppTheme.line)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
