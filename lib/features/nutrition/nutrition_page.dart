import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/nutrition/add_custom_food_dialog.dart';
import 'package:weightvault/features/nutrition/add_food_dialog.dart';
import 'package:weightvault/features/nutrition/nutrition_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class NutritionPage extends ConsumerWidget {
  const NutritionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(todayFoodEntriesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.nutritionTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const AddFoodDialog(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.restaurant_menu),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const AddCustomFoodDialog(),
            ),
          ),
        ],
      ),
      body: AsyncValueView<List<FoodEntry>>(
        value: entriesAsync,
        data: (entries) {
          final totals = entries.fold(
            const FoodTotals(cal: 0, protein: 0, carb: 0, fat: 0),
            (sum, entry) => FoodTotals(
              cal: sum.cal + entry.totals.cal,
              protein: sum.protein + entry.totals.protein,
              carb: sum.carb + entry.totals.carb,
              fat: sum.fat + entry.totals.fat,
            ),
          );
          final totalsByMeal = _totalsByMeal(entries);
          final itemsByMeal = _itemsByMeal(entries);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.todayTotalsTitle, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(strings.caloriesValue(totals.cal.toStringAsFixed(0))),
                    Text(strings.proteinValue(totals.protein.toStringAsFixed(1))),
                    Text(strings.carbValue(totals.carb.toStringAsFixed(1))),
                    Text(strings.fatValue(totals.fat.toStringAsFixed(1))),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ...MealType.values.map(
                (meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _mealSummaryCard(
                    context,
                    strings,
                    meal,
                    totalsByMeal[meal] ?? const FoodTotals(cal: 0, protein: 0, carb: 0, fat: 0),
                    itemsByMeal[meal] ?? const [],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Map<MealType, FoodTotals> _totalsByMeal(List<FoodEntry> entries) {
    final totals = {
      for (final meal in MealType.values)
        meal: const FoodTotals(cal: 0, protein: 0, carb: 0, fat: 0),
    };
    for (final entry in entries) {
      final current = totals[entry.mealType] ??
          const FoodTotals(cal: 0, protein: 0, carb: 0, fat: 0);
      totals[entry.mealType] = FoodTotals(
        cal: current.cal + entry.totals.cal,
        protein: current.protein + entry.totals.protein,
        carb: current.carb + entry.totals.carb,
        fat: current.fat + entry.totals.fat,
      );
    }
    return totals;
  }

  Widget _mealSummaryCard(
    BuildContext context,
    AppLocalizations strings,
    MealType meal,
    FoodTotals totals,
    List<FoodItem> items,
  ) {
    final theme = Theme.of(context);
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _mealTitle(strings, meal),
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(strings.caloriesValue(totals.cal.toStringAsFixed(0))),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 4,
                  children: [
                    Text(
                      strings.proteinValue(totals.protein.toStringAsFixed(1)),
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      strings.carbValue(totals.carb.toStringAsFixed(1)),
                      style: theme.textTheme.bodySmall,
                    ),
                    Text(
                      strings.fatValue(totals.fat.toStringAsFixed(1)),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (items.isEmpty)
                  Text(
                    strings.emptyLogTitle,
                    style: theme.textTheme.bodySmall,
                  )
                else
                  ...items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.foodItemCalories(
                              item.name,
                              item.cal.toStringAsFixed(0),
                            ),
                            style: theme.textTheme.bodySmall,
                          ),
                          Text(
                            _itemMacroLine(item),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => AddFoodDialog(initialMealType: meal),
            ),
            style: FilledButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
              minimumSize: const Size(44, 44),
            ),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  Map<MealType, List<FoodItem>> _itemsByMeal(List<FoodEntry> entries) {
    final items = {
      for (final meal in MealType.values) meal: <FoodItem>[],
    };
    for (final entry in entries) {
      final list = items[entry.mealType];
      if (list == null) continue;
      list.addAll(entry.items);
    }
    return items;
  }

  String _itemMacroLine(FoodItem item) {
    return 'P ${item.protein.toStringAsFixed(1)}g | '
        'C ${item.carb.toStringAsFixed(1)}g | '
        'F ${item.fat.toStringAsFixed(1)}g';
  }

  String _mealTitle(AppLocalizations strings, MealType meal) {
    final isTurkish = strings.localeName.startsWith('tr');
    switch (meal) {
      case MealType.breakfast:
        return isTurkish ? 'Kahvalti' : strings.mealBreakfast;
      case MealType.lunch:
        return isTurkish ? 'Ogle Yemegi' : strings.mealLunch;
      case MealType.dinner:
        return isTurkish ? 'Aksam Yemegi' : strings.mealDinner;
      case MealType.snack:
        return isTurkish ? 'Aperatifler' : strings.mealSnack;
    }
  }
}
