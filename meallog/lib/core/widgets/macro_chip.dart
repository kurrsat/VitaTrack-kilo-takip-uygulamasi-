import 'package:flutter/material.dart';

class MacroChip extends StatelessWidget {
  const MacroChip({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text('$label $value', style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
