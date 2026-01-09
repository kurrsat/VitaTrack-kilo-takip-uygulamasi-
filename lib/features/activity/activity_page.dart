import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/activity/activity_providers.dart';
import 'package:weightvault/features/activity/add_activity_dialog.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class ActivityPage extends ConsumerWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final activitiesAsync = ref.watch(activityEntriesProvider);
    final stepsAsync = ref.watch(todayStepsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.activityTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const AddActivityDialog(),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: stepsAsync.when(
              data: (steps) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.stepsToday, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(strings.stepsCount(steps)),
                ],
              ),
              loading: () => LoadingView(label: strings.fetchingSteps),
              error: (error, _) => ErrorState(title: strings.stepsErrorTitle, message: error.toString()),
            ),
          ),
          const SizedBox(height: 16),
          AsyncValueView<List<ActivityEntry>>(
            value: activitiesAsync,
            data: (entries) {
              if (entries.isEmpty) {
                return EmptyState(
                  title: strings.noActivitiesTitle,
                  message: strings.noActivitiesMessage,
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.workoutsTitle, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...entries.map(
                    (entry) => ListTile(
                      title: Text(entry.type),
                      subtitle: Text(strings.workoutDetails(entry.durationMin, entry.calories)),
                      trailing: Text(entry.source.name),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
