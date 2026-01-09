import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:water_reminder/app/exit_handler.dart';

/// Stats page with Day/Week/Month tabs and demo data.
class StatsPageContent extends StatefulWidget {
  const StatsPageContent({super.key});

  @override
  State<StatsPageContent> createState() => _StatsPageContentState();
}

class _StatsPageContentState extends State<StatsPageContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final List<StatsTabData> _tabs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabs = DemoStatsData.build();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const _StatsBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      WaterBackButton(),
                      SizedBox(width: 8),
                      Expanded(child: _StatsTitle()),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SegmentedTabs(
                    controller: _tabController,
                    labels: const ['Gun', 'Hafta', 'Ay'],
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTab(_tabs[0]),
                      _buildTab(_tabs[1], showCompletionRow: true),
                      _buildTab(_tabs[2]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(StatsTabData data, {bool showCompletionRow = false}) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: SingleChildScrollView(
        key: ValueKey(data.label),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StatsHeader(
              label: data.label,
              primaryValue: data.primaryValue,
              primaryUnit: data.primaryUnit,
              secondaryLabel: data.secondaryLabel,
              secondaryValue: data.secondaryValue,
            ),
            const SizedBox(height: 16),
            _ChartCard(data: data),
            if (showCompletionRow) ...[
              const SizedBox(height: 16),
              _WeekCompletionRow(
                labels: data.labels,
                completions: data.completionFlags,
              ),
            ],
            const SizedBox(height: 20),
            const Text(
              'Icilen kayitlar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            ...data.logs.asMap().entries.map((entry) {
              final index = entry.key;
              final log = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: index == data.logs.length - 1 ? 0 : 12),
                child: GlassLogCard(
                  amountMl: log.amountMl,
                  time: log.timeLabel,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _StatsTitle extends StatelessWidget {
  const _StatsTitle();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Detayli gecmis',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Gunluk su hedefini yakala',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _ChartCard extends StatelessWidget {
  const _ChartCard({required this.data});

  final StatsTabData data;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Hidratasyon trend grafigi',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: SizedBox(
              height: 180,
              child: StatsLineChart(
                series: data.series,
                labels: data.labels,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatsHeader extends StatelessWidget {
  const StatsHeader({
    super.key,
    required this.label,
    required this.primaryValue,
    required this.primaryUnit,
    required this.secondaryLabel,
    required this.secondaryValue,
  });

  final String label;
  final int primaryValue;
  final String primaryUnit;
  final String secondaryLabel;
  final String secondaryValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label $primaryValue $primaryUnit',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          primaryValue.toString(),
                          style: const TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        primaryUnit,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    secondaryLabel,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    secondaryValue,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SegmentedTabs extends StatelessWidget {
  const SegmentedTabs({
    super.key,
    required this.controller,
    required this.labels,
  });

  final TabController controller;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TabBar(
        controller: controller,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 3, color: Colors.white),
          insets: EdgeInsets.symmetric(horizontal: 22),
        ),
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        tabs: labels.map((label) => Tab(text: label)).toList(),
      ),
    );
  }
}

class GlassLogCard extends StatelessWidget {
  const GlassLogCard({
    super.key,
    required this.amountMl,
    required this.time,
  });

  final int amountMl;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Icilen kayit $amountMl ml saat $time',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white24),
            ),
            child: Row(
              children: [
                Text(
                  '$amountMl ml',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatsLineChart extends StatelessWidget {
  const StatsLineChart({
    super.key,
    required this.series,
    required this.labels,
  });

  final List<double> series;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final maxY = series.isEmpty
        ? 2000.0
        : series.reduce((a, b) => a > b ? a : b) * 1.25;
    final spots = List.generate(
      series.length,
      (index) => FlSpot(index.toDouble(), series[index]),
    );

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 3,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white24,
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 26,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= labels.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    labels[index],
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white70,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            barWidth: 3,
            color: Colors.white,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.35),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekCompletionRow extends StatelessWidget {
  const _WeekCompletionRow({
    required this.labels,
    required this.completions,
  });

  final List<String> labels;
  final List<bool> completions;

  @override
  Widget build(BuildContext context) {
    final todayIndex = DateTime.now().weekday - 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Haftalik tamamlama',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(labels.length, (index) {
            final isComplete = completions[index];
            final isToday = index == todayIndex;
            return Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isToday
                              ? Colors.white
                              : Colors.white.withOpacity(0.2),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        labels[index].substring(0, 1),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isComplete)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 12,
                            color: Color(0xFF0B4DB8),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  labels[index],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class _StatsBackground extends StatelessWidget {
  const _StatsBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0B4DB8),
            Color(0xFF1A7FE8),
          ],
        ),
      ),
      child: Stack(
        children: const [
          Positioned(
            right: -80,
            top: -60,
            child: _GlowOrb(size: 220, opacity: 0.18),
          ),
          Positioned(
            left: -60,
            bottom: -80,
            child: _GlowOrb(size: 240, opacity: 0.14),
          ),
        ],
      ),
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.opacity,
  });

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}

class DemoStatsData {
  static List<StatsTabData> build() {
    const goal = 2000;
    final daySeries = <double>[320, 560, 820, 1120, 1380, 1698];
    final dayLabels = ['06', '09', '12', '15', '18', '21'];
    final weekSeries = <double>[1400, 1650, 2100, 900, 1950, 1800, 2300];
    final weekLabels = ['Pzt', 'Sal', 'Car', 'Per', 'Cum', 'Cmt', 'Paz'];
    final monthSeries = <double>[
      1200,
      1600,
      1400,
      1900,
      1500,
      1750,
      1680,
      2100,
      1950,
      1700,
      1600,
      1850,
    ];
    final monthLabels = [
      '1',
      '4',
      '7',
      '10',
      '13',
      '16',
      '19',
      '22',
      '25',
      '28',
      '30',
      '31',
    ];

    return [
      StatsTabData(
        label: 'Gunluk ortalama',
        primaryValue: _average(daySeries),
        primaryUnit: 'ml',
        secondaryLabel: 'Toplam',
        secondaryValue: _liters(daySeries),
        series: daySeries,
        labels: dayLabels,
        logs: _demoLogs(),
        goalMl: goal,
      ),
      StatsTabData(
        label: 'Haftalik ortalama',
        primaryValue: _average(weekSeries),
        primaryUnit: 'ml',
        secondaryLabel: 'Hedef tutturma',
        secondaryValue: _completionPercent(weekSeries, goal),
        series: weekSeries,
        labels: weekLabels,
        logs: _demoLogs(),
        goalMl: goal,
      ),
      StatsTabData(
        label: 'Aylik ortalama',
        primaryValue: _average(monthSeries),
        primaryUnit: 'ml',
        secondaryLabel: 'Toplam',
        secondaryValue: _liters(monthSeries),
        series: monthSeries,
        labels: monthLabels,
        logs: _demoLogs(),
        goalMl: goal,
      ),
    ];
  }

  static int _average(List<double> values) {
    if (values.isEmpty) return 0;
    return (values.reduce((a, b) => a + b) / values.length).round();
  }

  static String _liters(List<double> values) {
    final total = values.isEmpty ? 0.0 : values.reduce((a, b) => a + b);
    return '${(total / 1000).toStringAsFixed(1)} L';
  }

  static String _completionPercent(List<double> values, int goal) {
    if (values.isEmpty || goal == 0) return '0%';
    final completed = values.where((value) => value >= goal).length;
    final percent = (completed / values.length * 100).round();
    return '$percent%';
  }

  static List<LogEntry> _demoLogs() {
    return const [
      LogEntry(amountMl: 200, timeLabel: '08:15'),
      LogEntry(amountMl: 280, timeLabel: '10:40'),
      LogEntry(amountMl: 240, timeLabel: '12:05'),
      LogEntry(amountMl: 180, timeLabel: '14:30'),
      LogEntry(amountMl: 300, timeLabel: '18:35'),
    ];
  }
}

class StatsTabData {
  const StatsTabData({
    required this.label,
    required this.primaryValue,
    required this.primaryUnit,
    required this.secondaryLabel,
    required this.secondaryValue,
    required this.series,
    required this.labels,
    required this.logs,
    required this.goalMl,
  });

  final String label;
  final int primaryValue;
  final String primaryUnit;
  final String secondaryLabel;
  final String secondaryValue;
  final List<double> series;
  final List<String> labels;
  final List<LogEntry> logs;
  final int goalMl;

  List<bool> get completionFlags =>
      series.map((value) => value >= goalMl).toList();
}

class LogEntry {
  const LogEntry({
    required this.amountMl,
    required this.timeLabel,
  });

  final int amountMl;
  final String timeLabel;
}
