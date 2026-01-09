import 'package:flutter/material.dart';
import 'package:meallog/core/widgets/macro_chip.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';

class MealCard extends StatelessWidget {
  const MealCard({
    required this.title,
    required this.total,
    required this.onTap,
    required this.onAdd,
    required this.leading,
    super.key,
  });

  final String title;
  final NutritionTotals total;
  final VoidCallback onTap;
  final VoidCallback onAdd;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(leading, color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        MacroChip(label: 'Kcal', value: total.kcal.toStringAsFixed(0)),
                        MacroChip(label: 'P', value: total.protein.toStringAsFixed(1)),
                        MacroChip(label: 'C', value: total.carbs.toStringAsFixed(1)),
                        MacroChip(label: 'F', value: total.fat.toStringAsFixed(1)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                style: FilledButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: onAdd,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
