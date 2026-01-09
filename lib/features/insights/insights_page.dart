import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';
class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(weightEntriesProvider);
    final trendService = ref.watch(trendServiceProvider);
    final settings = ref.watch(trendSettingsProvider);
    final profile = ref.watch(userProfileProvider).value;
    final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
    final flags = ref.watch(featureFlagServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.weeklyInsightsTitle),
      ),
      body: AsyncValueView(
        value: entriesAsync,
        data: (entries) {
          if (entries.isEmpty) {
            return EmptyState(
              title: strings.noInsightsTitle,
              message: strings.noInsightsMessage,
            );
          }
          final cutoff = DateTime.now().toUtc().subtract(const Duration(days: 7));
          final week = entries.where((e) => e.dateTime.isAfter(cutoff)).toList();
          if (week.isEmpty) {
            return EmptyState(
              title: strings.noRecentDataTitle,
              message: strings.noRecentDataMessage,
            );
          }
          final trend = trendService.calculateTrend(
            week,
            method: settings.method,
            alpha: settings.alpha,
            beta: settings.beta,
          );
          final change = week.last.weightKg - week.first.weightKg;
          final trendSpeed = trend.last - trend.first;

          final showAdaptive = flags.adaptiveGoalsEnabled && (profile?.adaptiveGoalsEnabled ?? false);
          final adaptiveCard = () {
            if (!showAdaptive || profile == null || profile.birthYear == null || profile.gender == null) {
              return const SizedBox.shrink();
            }
            final age = DateTime.now().year - profile.birthYear!;
            final bmr = adaptiveService.calculateBmr(
              weightKg: week.last.weightKg,
              heightCm: profile.heightCm,
              age: age,
              gender: profile.gender!,
            );
            final tdee = adaptiveService.calculateTdee(bmr: bmr);
            final trendDelta = trend.last - trend.first;
            final adjusted = adaptiveService.adjustCalorieTarget(
              currentTarget: profile.tdeeTarget ?? tdee,
              trendKgPerWeek: trendDelta,
              isGoalLoss: profile.goalType == GoalType.lose,
            );
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.adaptiveTargetTitle, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(strings.bmrValue(bmr.toStringAsFixed(0))),
                  Text(strings.tdeeValue(tdee.toStringAsFixed(0))),
                  Text(strings.suggestedValue(adjusted.toStringAsFixed(0))),
                ],
              ),
            );
          }();

          final changeLabel =
              change >= 0 ? '+${change.toStringAsFixed(2)}' : change.toStringAsFixed(2);
          final trendLabel = trendSpeed >= 0
              ? '+${trendSpeed.toStringAsFixed(2)}'
              : trendSpeed.toStringAsFixed(2);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              PrimaryButton(
                label: strings.weeklyReportTitle,
                onPressed: () => context.push('/weekly-report'),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.weeklyChangeTitle, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(strings.weightChangeValue(changeLabel)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.trendSpeedTitle, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(strings.trendSpeedValue(trendLabel)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.consistencyTitle, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(strings.consistencyMessage(week.length)),
                  ],
                ),
              ),
              if (showAdaptive) ...[
                const SizedBox(height: 16),
                adaptiveCard,
              ],
            ],
          );
        },
      ),
    );
  }
}
