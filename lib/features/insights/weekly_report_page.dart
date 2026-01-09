import 'dart:ui' as ui;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/features/insights/weekly_report_provider.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class WeeklyReportPage extends ConsumerStatefulWidget {
  const WeeklyReportPage({super.key});

  @override
  ConsumerState<WeeklyReportPage> createState() => _WeeklyReportPageState();
}

class _WeeklyReportPageState extends ConsumerState<WeeklyReportPage> {
  final GlobalKey _captureKey = GlobalKey();
  bool _sharing = false;

  Future<void> _shareReport(WeeklyReport report) async {
    if (_sharing) return;
    setState(() => _sharing = true);
    try {
      final strings = AppLocalizations.of(context)!;
      if (kIsWeb) {
        await Share.share(strings.weeklyReportShareText);
        return;
      }
      final boundary =
          _captureKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return;
      }
      final image = await boundary.toImage(pixelRatio: 3);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      final data = bytes?.buffer.asUint8List();
      if (data == null) {
        return;
      }
      final file = XFile.fromData(
        data,
        mimeType: 'image/png',
        name: 'weightvault_weekly_report.png',
      );
      await Share.shareXFiles([file], text: strings.weeklyReportShareText);
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final reportAsync = ref.watch(weeklyReportProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.weeklyReportTitle),
        actions: [
          IconButton(
            icon: _sharing
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.share),
            onPressed: reportAsync.value == null ? null : () => _shareReport(reportAsync.value!),
          ),
        ],
      ),
      body: AsyncValueView<WeeklyReport?>(
        value: reportAsync,
        data: (report) {
          if (report == null || !report.hasWeightData) {
            return EmptyState(
              title: strings.noInsightsTitle,
              message: strings.noInsightsMessage,
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              RepaintBoundary(
                key: _captureKey,
                child: _ReportCard(report: report),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.report});

  final WeeklyReport report;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final dateLabel = DateFormat.yMMMd().format(report.startDate.toLocal());
    final endLabel = DateFormat.yMMMd().format(report.endDate.toLocal());
    final changeLabel =
        report.weightChange >= 0 ? '+${report.weightChange.toStringAsFixed(2)}' : report.weightChange.toStringAsFixed(2);
    final trendLabel =
        report.trendSpeed >= 0 ? '+${report.trendSpeed.toStringAsFixed(2)}' : report.trendSpeed.toStringAsFixed(2);
    final weightSpots = report.weightSeries
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
    final trendSpots = report.trendSeries
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
    final waterSpots = report.waterSeries
        .asMap()
        .entries
        .map(
          (entry) => BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value.toDouble(),
                width: 10,
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ),
        )
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.weeklyReportTitle, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text('$dateLabel - $endLabel', style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          Text(strings.weeklySummaryTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          _ReportRow(
            label: strings.weeklyWeightChangeLabel,
            value: strings.weightChangeValue(changeLabel),
          ),
          _ReportRow(
            label: strings.weeklyTrendSpeedLabel,
            value: strings.trendSpeedValue(trendLabel),
          ),
          _ReportRow(
            label: strings.weeklyWaterAdherenceLabel,
            value: strings.weeklyWaterAdherenceValue(report.waterGoalDays, report.days.length),
          ),
          const SizedBox(height: 16),
          Text(strings.trendTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: weightSpots,
                    isCurved: true,
                    color: Theme.of(context).colorScheme.primary,
                    dotData: const FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: trendSpots,
                    isCurved: true,
                    color: Theme.of(context).colorScheme.secondary,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(strings.waterWeekTitle, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: BarChart(
              BarChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: waterSpots,
                maxY: AppConstants.defaultWaterGoalMl.toDouble() * 1.2,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            strings.weeklyGeneratedLabel(DateFormat.yMMMd().add_Hm().format(DateTime.now())),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  const _ReportRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
