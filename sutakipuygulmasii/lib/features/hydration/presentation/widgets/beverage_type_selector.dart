import 'package:flutter/material.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';

/// Beverage type selector widget
/// Shows chips for each beverage type with icon and color
class BeverageTypeSelector extends StatelessWidget {
  final BeverageType selectedType;
  final ValueChanged<BeverageType> onTypeSelected;

  const BeverageTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Icecek Turu',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: BeverageType.values.map((type) {
            final isSelected = selectedType == type;
            return ChoiceChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    type.icon,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    type.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              selectedColor: type.color.withOpacity(0.3),
              backgroundColor: Colors.grey.shade100,
              onSelected: (_) => onTypeSelected(type),
              side: BorderSide(
                color: isSelected ? type.color : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        // Show hydration multiplier info
        if (selectedType != BeverageType.water)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: selectedType.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selectedType.color.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: selectedType.color,
                ),
                const SizedBox(width: 8),
                Text(
                  'Hidratasyon degeri: ${selectedType.hydrationPercentage}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Helper widget to show effective hydration info
class EffectiveHydrationInfo extends StatelessWidget {
  final int amountMl;
  final BeverageType beverageType;

  const EffectiveHydrationInfo({
    super.key,
    required this.amountMl,
    required this.beverageType,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveMl = beverageType.calculateEffectiveHydration(amountMl);
    
    if (beverageType == BeverageType.water || effectiveMl == amountMl) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.water_drop,
            size: 16,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 8),
          Text(
            '$amountMl ml ${beverageType.label} ~ $effectiveMl ml hidratasyon',
            style: TextStyle(
              fontSize: 13,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
