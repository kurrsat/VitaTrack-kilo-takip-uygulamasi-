import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meallog/core/utils/nutrition_calculator.dart';
import 'package:meallog/core/widgets/primary_button.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/presentation/controllers/meal_log_providers.dart';
import 'package:meallog/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class PortionArgs {
  PortionArgs({required this.item, required this.mealType});

  final FoodSearchItem item;
  final MealType mealType;
}

class PortionPage extends ConsumerStatefulWidget {
  const PortionPage({required this.args, super.key});

  final PortionArgs args;

  @override
  ConsumerState<PortionPage> createState() => _PortionPageState();
}

class _PortionPageState extends ConsumerState<PortionPage> {
  late final TextEditingController _gramsController;
  double _grams = 100;

  @override
  void initState() {
    super.initState();
    _gramsController = TextEditingController(text: '100');
  }

  @override
  void dispose() {
    _gramsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final totals = calculateFromPer100g(
      grams: _grams,
      kcal: widget.args.item.per100gKcal,
      protein: widget.args.item.per100gProtein,
      carbs: widget.args.item.per100gCarbs,
      fat: widget.args.item.per100gFat,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.portion),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(widget.args.item.name, style: Theme.of(context).textTheme.titleLarge),
          if (widget.args.item.brand != null) ...[
            const SizedBox(height: 4),
            Text(widget.args.item.brand!, style: Theme.of(context).textTheme.bodySmall),
          ],
          const SizedBox(height: 16),
          TextField(
            controller: _gramsController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: strings.grams,
              suffixText: 'g',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onChanged: (value) {
              final parsed = double.tryParse(value.replaceAll(',', '.'));
              setState(() => _grams = parsed ?? 0);
            },
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${totals.kcal.toStringAsFixed(0)} ${strings.calories}'),
                  const SizedBox(height: 8),
                  Text('P ${totals.protein.toStringAsFixed(1)}'),
                  Text('C ${totals.carbs.toStringAsFixed(1)}'),
                  Text('F ${totals.fat.toStringAsFixed(1)}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            label: strings.addToMeal,
            onPressed: () async {
              final entry = FoodEntry(
                id: const Uuid().v4(),
                date: DateTime.now(),
                mealType: widget.args.mealType,
                name: widget.args.item.name,
                brand: widget.args.item.brand,
                grams: _grams,
                kcal: totals.kcal,
                protein: totals.protein,
                carbs: totals.carbs,
                fat: totals.fat,
                createdAt: DateTime.now(),
              );
              await ref.read(dayLogControllerProvider.notifier).addEntry(entry);
              ref.read(updateRecentsProvider)(widget.args.item);
              if (context.mounted) {
                context.go('/');
              }
            },
          ),
        ],
      ),
    );
  }
}
