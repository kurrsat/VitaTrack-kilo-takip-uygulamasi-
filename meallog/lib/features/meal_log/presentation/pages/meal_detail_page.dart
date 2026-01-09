import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meallog/core/widgets/empty_view.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/presentation/controllers/meal_log_providers.dart';
import 'package:meallog/features/meal_log/presentation/widgets/entry_tile.dart';
import 'package:meallog/l10n/app_localizations.dart';

class MealDetailPage extends ConsumerWidget {
  const MealDetailPage({required this.mealType, super.key});

  final MealType mealType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context);
    final state = ref.watch(dayLogControllerProvider);
    final entries = state.log.entries.where((e) => e.mealType == mealType).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(_mealLabel(strings, mealType)),
      ),
      body: entries.isEmpty
          ? EmptyView(title: strings.noEntries, message: strings.tapToSee)
          : ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return EntryTile(
                  entry: entry,
                  onEdit: () => _showEditDialog(context, ref, entry, strings),
                  onDelete: () => ref.read(dayLogControllerProvider.notifier).deleteEntry(entry.id),
                );
              },
            ),
    );
  }

  String _mealLabel(AppLocalizations strings, MealType type) {
    switch (type) {
      case MealType.breakfast:
        return strings.breakfast;
      case MealType.lunch:
        return strings.lunch;
      case MealType.dinner:
        return strings.dinner;
      case MealType.snack:
        return strings.snack;
    }
  }

  Future<void> _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    FoodEntry entry,
    AppLocalizations strings,
  ) async {
    final controller = TextEditingController(text: entry.grams.toStringAsFixed(0));
    final updated = await showDialog<FoodEntry>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(strings.editEntry),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: strings.grams),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(strings.cancel),
            ),
            TextButton(
              onPressed: () {
                final parsed = double.tryParse(controller.text.replaceAll(',', '.'));
                if (parsed == null || parsed <= 0) {
                  Navigator.pop(context);
                  return;
                }
                final ratio = parsed / entry.grams;
                final updatedEntry = entry.copyWith(
                  grams: parsed,
                  kcal: entry.kcal * ratio,
                  protein: entry.protein * ratio,
                  carbs: entry.carbs * ratio,
                  fat: entry.fat * ratio,
                );
                Navigator.pop(context, updatedEntry);
              },
              child: Text(strings.save),
            ),
          ],
        );
      },
    );
    if (updated != null) {
      await ref.read(dayLogControllerProvider.notifier).updateEntry(updated);
    }
  }
}
