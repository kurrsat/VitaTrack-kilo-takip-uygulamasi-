import 'package:flutter/material.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/l10n/app_localizations.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    required this.item,
    required this.onTap,
    this.onFavorite,
    this.isFavorite = false,
    super.key,
  });

  final FoodSearchItem item;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    return ListTile(
      title: Text(item.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.brand != null && item.brand!.isNotEmpty)
            Text(item.brand!, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 4),
          Text(
            '${item.per100gKcal?.toStringAsFixed(0) ?? '-'} ${strings.calories} / ${strings.per100g}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: [
              Text('P ${_macro(item.per100gProtein)}'),
              Text('C ${_macro(item.per100gCarbs)}'),
              Text('F ${_macro(item.per100gFat)}'),
            ],
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.isVerified)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(strings.verified, style: Theme.of(context).textTheme.labelSmall),
            ),
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: onFavorite,
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  String _macro(double? value) => value == null ? '-' : value.toStringAsFixed(1);
}
