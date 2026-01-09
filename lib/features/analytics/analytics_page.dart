import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AnalyticsPage extends ConsumerStatefulWidget {
  const AnalyticsPage({super.key});

  @override
  ConsumerState<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends ConsumerState<AnalyticsPage> {
  int _rangeDays = 30;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(weightEntriesProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.analytics),
      ),
      body: AsyncValueView<List<WeightEntry>>(
        value: entriesAsync,
        data: (entries) {
          if (entries.length < 2) {
            return EmptyState(
              title: strings.noDataTitle,
              message: strings.noDataAnalyticsMessage,
            );
          }
          final cutoff = DateTime.now().toUtc().subtract(Duration(days: _rangeDays));
          final filtered = entries.where((e) => e.dateTime.isAfter(cutoff)).toList();
          if (filtered.length < 2) {
            return EmptyState(
              title: strings.noDataTitle,
              message: strings.noDataAnalyticsMessage,
            );
          }
          final spots = filtered
              .asMap()
              .entries
              .map((entry) => FlSpot(entry.key.toDouble(), entry.value.weightKg))
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: Text(strings.range7d),
                    selected: _rangeDays == 7,
                    onSelected: (_) => setState(() => _rangeDays = 7),
                  ),
                  ChoiceChip(
                    label: Text(strings.range30d),
                    selected: _rangeDays == 30,
                    onSelected: (_) => setState(() => _rangeDays = 30),
                  ),
                  ChoiceChip(
                    label: Text(strings.range6m),
                    selected: _rangeDays == 180,
                    onSelected: (_) => setState(() => _rangeDays = 180),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              AppCard(
                child: SizedBox(
                  height: 240,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          color: Theme.of(context).colorScheme.primary,
                          dotData: const FlDotData(show: false),
                          barWidth: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
