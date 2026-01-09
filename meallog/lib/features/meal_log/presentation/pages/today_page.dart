import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meallog/core/utils/date_utils.dart';
import 'package:meallog/core/widgets/error_view.dart';
import 'package:meallog/core/widgets/loading_view.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/presentation/controllers/meal_log_providers.dart';
import 'package:meallog/features/meal_log/presentation/widgets/daily_summary_card.dart';
import 'package:meallog/features/meal_log/presentation/widgets/meal_card.dart';
import 'package:meallog/l10n/app_localizations.dart';

class TodayPage extends ConsumerWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dayLogControllerProvider);
    final strings = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.today),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.go('/search/${MealType.breakfast.key}'),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('MealLog'),
                  content: const Text('v0.1 � Offline-first yemek g�nl���'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(dayLogControllerProvider.notifier).load(),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              formatDayTitle(state.date, locale),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            if (state.isLoading) const LoadingView(),
            if (!state.isLoading && state.errorMessage != null)
              ErrorView(
                title: strings.tryAgain,
                message: state.errorMessage!,
                retryLabel: strings.tryAgain,
                onRetry: () => ref.read(dayLogControllerProvider.notifier).load(),
              ),
            if (!state.isLoading && state.errorMessage == null) ...[
              DailySummaryCard(summary: state.log.summary),
              const SizedBox(height: 12),
              ...MealType.values.map((mealType) {
                final label = _mealLabel(strings, mealType);
                final icon = _mealIcon(mealType);
                final total = state.log.summary.perMeal[mealType] ??
                    state.log.summary.total;
                return MealCard(
                  title: label,
                  total: total,
                  leading: icon,
                  onTap: () => context.go('/meal/${mealType.key}'),
                  onAdd: () => context.go('/search/${mealType.key}'),
                );
              }),
            ],
          ],
        ),
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

  IconData _mealIcon(MealType type) {
    switch (type) {
      case MealType.breakfast:
        return Icons.wb_sunny_outlined;
      case MealType.lunch:
        return Icons.bento_outlined;
      case MealType.dinner:
        return Icons.nightlight_round;
      case MealType.snack:
        return Icons.cookie_outlined;
    }
  }
}
