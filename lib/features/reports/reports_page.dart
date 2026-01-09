import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/activity/activity_providers.dart';
import 'package:weightvault/features/reports/reports_providers.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/features/water/water_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class ReportsPage extends ConsumerWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final foodAsync = ref.watch(allFoodEntriesProvider);
    final weightAsync = ref.watch(weightEntriesProvider);
    final waterAsync = ref.watch(waterHistoryProvider);
    final activityAsync = ref.watch(activityEntriesProvider);
    final profile = ref.watch(userProfileProvider).value;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Header
               const Text(
                  'Raporlar',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Date Label (Simple "Last 7 Days" for now)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2dd4bf),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Son 7 Gün',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 1. Calories Section
                _buildCalorieSection(context, strings, foodAsync, profile),
                const SizedBox(height: 24),

                // 2. Weight Section
                _buildWeightSection(context, strings, weightAsync),
                const SizedBox(height: 24),

                // 3. Water Section
                _buildWaterSection(context, strings, waterAsync),
                const SizedBox(height: 24),

                // 4. Activity Section
                _buildActivitySection(context, strings, activityAsync),
                const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalorieSection(BuildContext context, AppLocalizations strings, AsyncValue<List<FoodEntry>> asyncData, UserProfile? profile) {
    return asyncData.when(
      data: (entries) {
        final now = DateTime.now();
        final buckets = _buildFoodBuckets(entries, now);
        final weeklyTotal = buckets.fold<double>(0, (sum, b) => sum + b.totalCalories);
        final dailyAverage = buckets.isEmpty ? 0.0 : weeklyTotal / 7; // Average over 7 days

        return Column(
          children: [
             _SummaryCard(
               title: strings.caloriesTitle,
               value: '${weeklyTotal.toStringAsFixed(0)} kcal',
               subtitle: 'Günlük Ort: ${dailyAverage.toStringAsFixed(0)}',
               gradient: const LinearGradient(colors: [Color(0xFFF59E0B), Color(0xFFD97706)]),
               icon: Icons.local_fire_department,
             ),
             const SizedBox(height: 16),
             _ChartContainer(
               title: 'Kalori Grafiği',
               child: BarChart(
                 BarChartData(
                   alignment: BarChartAlignment.spaceAround,
                   maxY: buckets.map((b) => b.totalCalories).fold<double>(0, (max, v) => v > max ? v : max) * 1.2,
                   titlesData: _buildTitles(buckets.map((b) => b.date).toList()),
                   borderData: FlBorderData(show: false),
                   gridData: const FlGridData(show: false),
                   barGroups: buckets.asMap().entries.map((e) {
                     return BarChartGroupData(
                       x: e.key,
                       barRods: [BarChartRodData(toY: e.value.totalCalories, color: const Color(0xFFF59E0B), width: 12, borderRadius: BorderRadius.circular(4))],
                     );
                   }).toList(),
                 ),
               ),
             ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const Text('Veri yüklenemedi'),
    );
  }

  Widget _buildWeightSection(BuildContext context, AppLocalizations strings, AsyncValue<List<WeightEntry>> asyncData) {
    return asyncData.when(
      data: (entries) {
        final now = DateTime.now();
        final data = _buildWeightData(entries, now);
        // Calculate average / changes if needed
        final current = data.lastOrNull?.value ?? 0;
        
        return Column(
          children: [
             _SummaryCard(
               title: 'Kilo',
               value: '${current.toStringAsFixed(1)} kg',
               subtitle: 'Son tartım',
               gradient: const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF2563EB)]),
               icon: Icons.monitor_weight,
             ),
             const SizedBox(height: 16),
             _ChartContainer(
               title: 'Kilo Değişimi',
               child: LineChart(
                 LineChartData(
                   gridData: const FlGridData(show: false),
                   titlesData: _buildTitles(data.map((e) => e.date).toList()),
                   borderData: FlBorderData(show: false),
                   lineBarsData: [
                     LineChartBarData(
                       spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.value)).toList(),
                       isCurved: true,
                       color: const Color(0xFF3B82F6),
                       barWidth: 3,
                       belowBarData: BarAreaData(show: true, color: const Color(0xFF3B82F6).withOpacity(0.1)),
                     ),
                   ],
                 ),
               ),
             ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _buildWaterSection(BuildContext context, AppLocalizations strings, AsyncValue<List<WaterEntry>> asyncData) {
     return asyncData.when(
      data: (entries) {
        final now = DateTime.now();
        final buckets = _buildWaterBuckets(entries, now);
        final total = buckets.fold<double>(0, (sum, b) => sum + b.value);
        final avg = total / 7;

        return Column(
          children: [
             _SummaryCard(
               title: 'Su Tüketimi',
               value: '${(total / 1000).toStringAsFixed(1)} L',
               subtitle: 'Haftalık Toplam',
               gradient: const LinearGradient(colors: [Color(0xFF06B6D4), Color(0xFF0891B2)]),
               icon: Icons.water_drop,
             ),
             const SizedBox(height: 16),
             _ChartContainer(
               title: 'Su Grafiği',
               child: BarChart(
                 BarChartData(
                   alignment: BarChartAlignment.spaceAround,
                   maxY: buckets.map((b) => b.value).fold<double>(0, (max, v) => v > max ? v : max) * 1.2,
                   titlesData: _buildTitles(buckets.map((b) => b.date).toList()),
                   borderData: FlBorderData(show: false),
                   gridData: const FlGridData(show: false),
                   barGroups: buckets.asMap().entries.map((e) {
                     return BarChartGroupData(
                       x: e.key,
                       barRods: [BarChartRodData(toY: e.value.value, color: const Color(0xFF06B6D4), width: 12, borderRadius: BorderRadius.circular(4))],
                     );
                   }).toList(),
                 ),
               ),
             ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _buildActivitySection(BuildContext context, AppLocalizations strings, AsyncValue<List<ActivityEntry>> asyncData) {
    return asyncData.when(
      data: (entries) {
        final now = DateTime.now();
        final buckets = _buildActivityBuckets(entries, now);
        final total = buckets.fold<double>(0, (sum, b) => sum + b.value); // Calories
        final avg = total / 7;

        return Column(
          children: [
             _SummaryCard(
               title: 'Aktivite',
               value: '${total.toStringAsFixed(0)} kcal',
               subtitle: 'Haftalık Yakılan',
               gradient: const LinearGradient(colors: [Color(0xFFEF4444), Color(0xFFB91C1C)]),
               icon: Icons.fitness_center,
             ),
             const SizedBox(height: 16),
             _ChartContainer(
               title: 'Aktivite Grafiği (kcal)',
               child: BarChart(
                 BarChartData(
                   alignment: BarChartAlignment.spaceAround,
                   maxY: buckets.map((b) => b.value).fold<double>(0, (max, v) => v > max ? v : max) * 1.2,
                   titlesData: _buildTitles(buckets.map((b) => b.date).toList()),
                   borderData: FlBorderData(show: false),
                   gridData: const FlGridData(show: false),
                   barGroups: buckets.asMap().entries.map((e) {
                     return BarChartGroupData(
                       x: e.key,
                       barRods: [BarChartRodData(toY: e.value.value, color: const Color(0xFFEF4444), width: 12, borderRadius: BorderRadius.circular(4))],
                     );
                   }).toList(),
                 ),
               ),
             ),
          ],
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const SizedBox(),
    );
  }

  // --- Logic Helpers ---

  List<_DataPoint> _buildFoodBuckets(List<FoodEntry> entries, DateTime now) {
    final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
    final buckets = List.generate(7, (index) => _DataPoint(start.add(Duration(days: index)), 0));
    
    for (final entry in entries) {
       if (entry.isDeleted) continue;
       final date = entry.dateTime.toLocal();
       final dayStart = DateTime(date.year, date.month, date.day);
       final diff = dayStart.difference(start).inDays;
       if (diff >= 0 && diff < 7) {
         buckets[diff].value += entry.totals.cal;
         buckets[diff].totalCalories = buckets[diff].value; // Alias
       }
    }
    return buckets;
  }

  List<_DataPoint> _buildWaterBuckets(List<WaterEntry> entries, DateTime now) {
    final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
    final buckets = List.generate(7, (index) => _DataPoint(start.add(Duration(days: index)), 0));

    for (final entry in entries) {
       if (entry.isDeleted) continue;
       final date = entry.lastUpdatedAt.toLocal();
       final dayStart = DateTime(date.year, date.month, date.day);
       final diff = dayStart.difference(start).inDays;
       if (diff >= 0 && diff < 7) {
         buckets[diff].value += entry.ml;
       }
    }
    return buckets;
  }

  List<_DataPoint> _buildWeightData(List<WeightEntry> entries, DateTime now) {
     if (entries.isEmpty) return [];
     // Sort by date
     final sorted = List<WeightEntry>.from(entries)..sort((a, b) => a.dateTime.compareTo(b.dateTime));
     // Take last 7 distinct days if possible, or just all within range
     final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
     
     // Filter entries within range
     final inRange = sorted.where((e) => e.dateTime.toLocal().isAfter(start.subtract(const Duration(days: 1)))).toList();
     
     // Map to data points. If multiple on same day, take latest?
     // Simplifying: Just Map 1-to-1 for line chart
     return inRange.map((e) => _DataPoint(e.dateTime.toLocal(), e.weightKg)).toList();
  }

  List<_DataPoint> _buildActivityBuckets(List<ActivityEntry> entries, DateTime now) {
    final start = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 6));
    final buckets = List.generate(7, (index) => _DataPoint(start.add(Duration(days: index)), 0));

    for (final entry in entries) {
       if (entry.isDeleted) continue;
       final date = entry.dateTime.toLocal();
       final dayStart = DateTime(date.year, date.month, date.day);
       final diff = dayStart.difference(start).inDays;
       if (diff >= 0 && diff < 7) {
         buckets[diff].value += entry.calories;
       }
    }
    return buckets;
  }

  FlTitlesData _buildTitles(List<DateTime> dates) {
    return FlTitlesData(
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
             final index = value.toInt();
             if (index < 0 || index >= dates.length) return const SizedBox.shrink();
             return Padding(
               padding: const EdgeInsets.only(top: 8),
               child: Text(DateFormat.E('tr').format(dates[index]), style: const TextStyle(fontSize: 10, color: Colors.grey)),
             );
          },
        ),
      ),
      leftTitles: const AxisTitles(),
      rightTitles: const AxisTitles(),
      topTitles: const AxisTitles(),
    );
  }
}

class _DataPoint {
  _DataPoint(this.date, this.value);
  final DateTime date;
  double value;
  double totalCalories = 0; // Helper for legacy naming if needed
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.value, required this.subtitle, required this.gradient, required this.icon});
  final String title;
  final String value;
  final String subtitle;
  final Gradient gradient;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (gradient as LinearGradient).colors.first.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartContainer extends StatelessWidget {
  const _ChartContainer({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(height: 200, child: child),
        ],
      ),
    );
  }
}
