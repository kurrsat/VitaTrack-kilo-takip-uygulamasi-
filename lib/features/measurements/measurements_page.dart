import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/measurements/add_measurement_dialog.dart';
import 'package:weightvault/features/measurements/measurement_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class MeasurementsPage extends ConsumerStatefulWidget {
  const MeasurementsPage({super.key});

  @override
  ConsumerState<MeasurementsPage> createState() => _MeasurementsPageState();
}

class _MeasurementsPageState extends ConsumerState<MeasurementsPage> {
  MeasurementMetric _metric = MeasurementMetric.waist;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(measurementEntriesProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const AppBackButton(color: Colors.white),
        title: Text(strings.measurementsTitle, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => showDialog<void>(
              context: context,
              builder: (_) => const AddMeasurementDialog(),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2CD8D5), // Cyan
              Color(0xFF6B8DD6), // Blue
              Color(0xFF8E37D7), // Purple
            ],
          ),
        ),
        child: SafeArea(
          child: AsyncValueView<List<MeasurementEntry>>(
            value: entriesAsync,
            data: (entries) {
              if (entries.isEmpty) {
                return EmptyState(
                  title: strings.noMeasurementsTitle,
                  message: strings.noMeasurementsMessage,
                  // Ensure empty state text is visible on gradient if needed, 
                  // but EmptyState usually deals with its own styling. 
                  // If it's standard text, it might need white color override.
                  // I'll assume EmptyState needs an update or I wrapper it. 
                  // For now let's leave it, often it has standard colors.
                );
              }
              final sorted = [...entries]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
              final points = <FlSpot>[];
              var latestValue = 0.0;
              for (final entry in sorted) {
                final value = _metricValue(entry, _metric);
                if (value == null) {
                  continue;
                }
                points.add(FlSpot(points.length.toDouble(), value));
                latestValue = value;
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: entries.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                strings.measurementChartTitle,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 12),
                              DropdownButtonFormField<MeasurementMetric>(
                                value: _metric,
                                decoration: InputDecoration(labelText: strings.measurementMetricLabel),
                                items: MeasurementMetric.values
                                    .map(
                                      (metric) => DropdownMenuItem(
                                        value: metric,
                                        child: Text(_metricLabel(strings, metric)),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() => _metric = value);
                                  }
                                },
                              ),
                              const SizedBox(height: 12),
                              Text(
                                strings.measurementLatestValue(
                                  latestValue.toStringAsFixed(1),
                                  _metricUnit(_metric),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 200,
                                child: LineChart(
                                  LineChartData(
                                    gridData: const FlGridData(show: false),
                                    titlesData: const FlTitlesData(show: false),
                                    borderData: FlBorderData(show: false),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: points,
                                        isCurved: true,
                                        color: Theme.of(context).colorScheme.primary,
                                        dotData: const FlDotData(show: false),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }
                  final entry = entries[index - 1];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.dateTime.toLocal().toString().split(' ').first,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(strings.measurementWaistHip(entry.waistCm, entry.hipCm)),
                          Text(strings.measurementChestNeck(entry.chestCm, entry.neckCm)),
                          Text(strings.measurementArmThigh(entry.armCm, entry.thighCm)),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

enum MeasurementMetric {
  waist,
  hip,
  chest,
  neck,
  arm,
  thigh,
  bodyFat,
  muscle,
  water,
}

double? _metricValue(MeasurementEntry entry, MeasurementMetric metric) {
  switch (metric) {
    case MeasurementMetric.waist:
      return entry.waistCm;
    case MeasurementMetric.hip:
      return entry.hipCm;
    case MeasurementMetric.chest:
      return entry.chestCm;
    case MeasurementMetric.neck:
      return entry.neckCm;
    case MeasurementMetric.arm:
      return entry.armCm;
    case MeasurementMetric.thigh:
      return entry.thighCm;
    case MeasurementMetric.bodyFat:
      return entry.bodyFatPct;
    case MeasurementMetric.muscle:
      return entry.musclePct;
    case MeasurementMetric.water:
      return entry.waterPct;
  }
}

String _metricUnit(MeasurementMetric metric) {
  switch (metric) {
    case MeasurementMetric.bodyFat:
    case MeasurementMetric.muscle:
    case MeasurementMetric.water:
      return '%';
    case MeasurementMetric.waist:
    case MeasurementMetric.hip:
    case MeasurementMetric.chest:
    case MeasurementMetric.neck:
    case MeasurementMetric.arm:
    case MeasurementMetric.thigh:
      return 'cm';
  }
}

String _metricLabel(AppLocalizations strings, MeasurementMetric metric) {
  switch (metric) {
    case MeasurementMetric.waist:
      return strings.metricWaist;
    case MeasurementMetric.hip:
      return strings.metricHip;
    case MeasurementMetric.chest:
      return strings.metricChest;
    case MeasurementMetric.neck:
      return strings.metricNeck;
    case MeasurementMetric.arm:
      return strings.metricArm;
    case MeasurementMetric.thigh:
      return strings.metricThigh;
    case MeasurementMetric.bodyFat:
      return strings.metricBodyFat;
    case MeasurementMetric.muscle:
      return strings.metricMuscle;
    case MeasurementMetric.water:
      return strings.metricWaterPct;
  }
}
