import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meallog/core/widgets/empty_view.dart';
import 'package:meallog/core/widgets/error_view.dart';
import 'package:meallog/core/widgets/loading_view.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/presentation/controllers/meal_log_providers.dart';
import 'package:meallog/features/meal_log/presentation/pages/portion_page.dart';
import 'package:meallog/features/meal_log/presentation/widgets/offline_banner.dart';
import 'package:meallog/features/meal_log/presentation/widgets/search_result_tile.dart';
import 'package:meallog/l10n/app_localizations.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({required this.mealType, super.key});

  final MealType mealType;

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);
    final state = ref.watch(searchControllerProvider);
    final notifier = ref.read(searchControllerProvider.notifier);
    final recents = ref.watch(recentItemsProvider);
    final favorites = ref.watch(favoriteItemsProvider);
    final toggleFavorite = ref.read(toggleFavoriteProvider);
    final saveRecent = ref.read(updateRecentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_mealLabel(strings, widget.mealType)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: strings.searchHint,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: notifier.updateQuery,
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => context.go('/manual/${widget.mealType.key}'),
            icon: const Icon(Icons.edit_note),
            label: Text(strings.manualEntry),
          ),
          const SizedBox(height: 16),
          recents.when(
            data: (items) => _QuickSection(
              title: strings.recent,
              items: items,
              onTap: (item) => _openPortion(context, item, saveRecent),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          favorites.when(
            data: (items) => _QuickSection(
              title: strings.favorites,
              items: items,
              onTap: (item) => _openPortion(context, item, saveRecent),
            ),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          const SizedBox(height: 12),
          if (state.fromCache || state.isFallback)
            OfflineBanner(
              message: state.isFallback ? strings.networkFallback : strings.offlineNotice,
            ),
          const SizedBox(height: 12),
          if (state.isLoading) const LoadingView(),
          if (!state.isLoading && state.errorMessage != null)
            ErrorView(
              title: strings.tryAgain,
              message: state.errorMessage!,
              retryLabel: strings.tryAgain,
              onRetry: () => notifier.updateQuery(state.query),
            ),
          if (!state.isLoading &&
              state.errorMessage == null &&
              state.items.isEmpty &&
              state.query.isNotEmpty)
            EmptyView(title: strings.emptySearch, message: strings.tryAgain),
          ...state.items.map(
            (item) => SearchResultTile(
              item: item,
              onTap: () => _openPortion(context, item, saveRecent),
              onFavorite: () => toggleFavorite(item),
              isFavorite: favorites.maybeWhen(
                data: (items) => items.any((fav) => fav.id == item.id),
                orElse: () => false,
              ),
            ),
          ),
        ],
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

  void _openPortion(
    BuildContext context,
    FoodSearchItem item,
    Future<void> Function(FoodSearchItem) saveRecent,
  ) {
    saveRecent(item);
    context.go('/portion', extra: PortionArgs(item: item, mealType: widget.mealType));
  }
}

class _QuickSection extends StatelessWidget {
  const _QuickSection({
    required this.title,
    required this.items,
    required this.onTap,
  });

  final String title;
  final List<FoodSearchItem> items;
  final void Function(FoodSearchItem) onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return ActionChip(
                label: Text(item.name),
                onPressed: () => onTap(item),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
