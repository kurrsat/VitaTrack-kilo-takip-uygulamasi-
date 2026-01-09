import 'package:flutter/material.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({
    required this.entry,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final FoodEntry entry;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(entry.name),
      subtitle: Text('${entry.grams.toStringAsFixed(0)} g � ${entry.kcal.toStringAsFixed(0)} kcal'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
          IconButton(icon: const Icon(Icons.delete_outline), onPressed: onDelete),
        ],
      ),
    );
  }
}
