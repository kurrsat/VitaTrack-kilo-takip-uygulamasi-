import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/presentation/pages/portion_page.dart';
import 'package:meallog/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

class ManualFoodPage extends StatefulWidget {
  const ManualFoodPage({required this.mealType, super.key});

  final MealType mealType;

  @override
  State<ManualFoodPage> createState() => _ManualFoodPageState();
}

class _ManualFoodPageState extends State<ManualFoodPage> {
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _kcalController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbController = TextEditingController();
  final _fatController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _kcalController.dispose();
    _proteinController.dispose();
    _carbController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(strings.manualEntry)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: strings.name),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brandController,
            decoration: InputDecoration(labelText: strings.brand),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _kcalController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: strings.kcalPer100g),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _proteinController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: strings.proteinPer100g),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _carbController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: strings.carbPer100g),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _fatController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(labelText: strings.fatPer100g),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () {
              final name = _nameController.text.trim();
              if (name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(strings.nameRequired)),
                );
                return;
              }
              final item = FoodSearchItem(
                id: const Uuid().v4(),
                name: name,
                brand: _brandController.text.trim().isEmpty
                    ? null
                    : _brandController.text.trim(),
                per100gKcal: _parse(_kcalController.text),
                per100gProtein: _parse(_proteinController.text),
                per100gCarbs: _parse(_carbController.text),
                per100gFat: _parse(_fatController.text),
                source: 'manual',
                isVerified: false,
              );
              context.go('/portion', extra: PortionArgs(item: item, mealType: widget.mealType));
            },
            child: Text(strings.addFood),
          ),
        ],
      ),
    );
  }

  double? _parse(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return null;
    return double.tryParse(trimmed.replaceAll(',', '.'));
  }
}
