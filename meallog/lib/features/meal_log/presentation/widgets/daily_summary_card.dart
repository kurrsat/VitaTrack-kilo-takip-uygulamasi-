import 'package:flutter/material.dart';
import 'package:meallog/core/widgets/macro_chip.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/l10n/app_localizations.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard({required this.summary, super.key});

  final DaySummary summary;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final total = summary.total;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.summary, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${total.kcal.toStringAsFixed(0)} ${strings.calories}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Icon(Icons.trending_up, color: Theme.of(context).colorScheme.primary),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                MacroChip(label: 'P', value: total.protein.toStringAsFixed(1)),
                MacroChip(label: 'C', value: total.carbs.toStringAsFixed(1)),
                MacroChip(label: 'F', value: total.fat.toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
