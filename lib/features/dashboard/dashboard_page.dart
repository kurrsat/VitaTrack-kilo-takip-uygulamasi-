import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/activity/activity_providers.dart';
import 'package:weightvault/features/measurements/measurement_providers.dart';
import 'package:weightvault/features/nutrition/nutrition_providers.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/features/water/water_providers.dart';
import 'package:weightvault/features/weight/add_weight_dialog.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final entriesAsync = ref.watch(weightEntriesProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final activityAsync = ref.watch(activityEntriesProvider);
    final measurementAsync = ref.watch(measurementEntriesProvider);
    final waterAsync = ref.watch(todayWaterProvider);
    final foodAsync = ref.watch(todayFoodEntriesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    strings.dashboard,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                  // Date Simulator (Static for UI match)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      'Bugün',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Weight Goal Card
            entriesAsync.when(
              data: (entries) {
                // Sort entries manually to be safe
                final sortedEntries = List<WeightEntry>.from(entries);
                sortedEntries.sort((a, b) => a.dateTime.compareTo(b.dateTime));

                final today = DateTime.now();
                final todaysEntry = sortedEntries.where((e) {
                  final date = e.dateTime.toLocal();
                  return date.year == today.year && date.month == today.month && date.day == today.day;
                }).firstOrNull;

                // Prioritize today's entry (immediate feedback), otherwise use the latest available
                final currentWeight = todaysEntry?.weightKg ?? (sortedEntries.isNotEmpty ? sortedEntries.last.weightKg : 0.0);
                
                final startWeight = sortedEntries.isNotEmpty ? sortedEntries.first.weightKg : currentWeight;
                final goalWeight = profileAsync.value?.goalWeight ?? 70.0;
                
                // Calculate progress
                final totalDiff = (startWeight - goalWeight).abs();
                final currentDiff = (currentWeight - goalWeight).abs();
                double progress = 0.0;
                if (totalDiff > 0) {
                  progress = (1 - (currentDiff / totalDiff)).clamp(0.0, 1.0);
                }
                
                return InkWell(
                  onTap: () async {
                    // Logic already finds todaysEntry correctly
                    if (todaysEntry != null) {
                      // Edit existing
                      await showDialog<void>(
                        context: context,
                        builder: (_) => AddWeightDialog(entry: todaysEntry),
                      );
                    } else {
                      // Add new
                       await showDialog<void>(
                        context: context,
                        builder: (_) => const AddWeightDialog(),
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(28),
                  child: _WeightGoalCard(
                    current: currentWeight,
                    target: goalWeight,
                    start: startWeight,
                    progress: progress,
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => const SizedBox.shrink(),
            ),

            const SizedBox(height: 24),

            // Daily Progress Section
            const Text(
              'Günlük İlerleme', // Strings not available for exact match, used mock
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _MiniProgressRing(
                    label: strings.caloriesTitle,
                    value: _sumFoodTotals(foodAsync.value ?? []).cal.toStringAsFixed(0),
                    unit: 'kcal',
                    target: (profileAsync.value?.tdeeTarget ?? 2000).toStringAsFixed(0),
                    color: const Color(0xFFF97316),
                    progress: (_sumFoodTotals(foodAsync.value ?? []).cal / (profileAsync.value?.tdeeTarget ?? 2000)).clamp(0.0, 1.0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MiniProgressRing(
                    label: strings.waterTrackerTitle,
                    value: _sumWater(waterAsync.value ?? []).toStringAsFixed(1),
                    unit: 'L',
                    target: '2.5 L',
                    color: const Color(0xFF3B82F6),
                    progress: (_sumWater(waterAsync.value ?? []) / 2.5).clamp(0.0, 1.0),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MiniProgressRing(
                    label: strings.activityTitle,
                    value: _sumTodayActivityMinutes(activityAsync.value ?? []).toString(),
                    unit: 'dk',
                    target: '60 dk',
                    color: const Color(0xFF22C55E),
                    progress: (_sumTodayActivityMinutes(activityAsync.value ?? []) / 60).clamp(0.0, 1.0),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Stats Grid
            // Nutrition Grid (Protein & Fat)
            Row(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final profile = profileAsync.value;
                      double tdee = 2000;
                      
                      if (profile != null) {
                        if (profile.tdeeTarget != null) {
                          tdee = profile.tdeeTarget!;
                        } else {
                          // Calculate dynamically if no specific target set
                           final entries = entriesAsync.value ?? [];
                           final latestWeight = entries.isNotEmpty ? entries.last.weightKg : profile.goalWeight;
                           final activityCal = _sumTodayActivityCalories(activityAsync.value ?? []);
                           final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
                           
                           if (profile.birthYear != null && profile.gender != null) {
                              final age = DateTime.now().year - profile.birthYear!;
                              if (age > 0) {
                                tdee = calculateDailyCalorieGoal(
                                  service: adaptiveService,
                                  weightKg: latestWeight,
                                  heightCm: profile.heightCm,
                                  age: age,
                                  gender: profile.gender!,
                                  activityCalories: activityCal,
                                  goalType: profile.goalType,
                                );
                              }
                           }
                        }
                      }

                      // Target: 25% of calories from protein. 1g protein = 4 cal.
                      final proteinTarget = (tdee * 0.25) / 4;
                      final currentProtein = _sumFoodTotals(foodAsync.value ?? []).protein;
                      
                      return _MacroProgressCard(
                        title: 'Protein',
                        consumed: currentProtein,
                        target: proteinTarget,
                        color: const Color(0xFFA855F7), // Purple
                        icon: Icons.fitness_center,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final profile = profileAsync.value;
                      double tdee = 2000;
                      
                      if (profile != null) {
                        if (profile.tdeeTarget != null) {
                          tdee = profile.tdeeTarget!;
                        } else {
                           // Calculate dynamically if no specific target set
                           final entries = entriesAsync.value ?? [];
                           final latestWeight = entries.isNotEmpty ? entries.last.weightKg : profile.goalWeight;
                           final activityCal = _sumTodayActivityCalories(activityAsync.value ?? []);
                           final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
                           
                           if (profile.birthYear != null && profile.gender != null) {
                              final age = DateTime.now().year - profile.birthYear!;
                              if (age > 0) {
                                tdee = calculateDailyCalorieGoal(
                                  service: adaptiveService,
                                  weightKg: latestWeight,
                                  heightCm: profile.heightCm,
                                  age: age,
                                  gender: profile.gender!,
                                  activityCalories: activityCal,
                                  goalType: profile.goalType,
                                );
                              }
                           }
                        }
                      }

                      // Target: 30% of calories from fat. 1g fat = 9 cal.
                      final fatTarget = (tdee * 0.30) / 9;
                      final currentFat = _sumFoodTotals(foodAsync.value ?? []).fat;

                      return _MacroProgressCard(
                        title: 'Yağ',
                        consumed: currentFat,
                        target: fatTarget,
                        color: const Color(0xFFEAB308), // Yellow/Gold
                        icon: Icons.opacity,
                      );
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

            // Carbohydrate Card (Full Width)
            Builder(
              builder: (context) {
                final profile = profileAsync.value;
                double tdee = 2000;
                
                if (profile != null) {
                  if (profile.tdeeTarget != null) {
                    tdee = profile.tdeeTarget!;
                  } else {
                     // Calculate dynamically if no specific target set
                     final entries = entriesAsync.value ?? [];
                     final latestWeight = entries.isNotEmpty ? entries.last.weightKg : profile.goalWeight;
                     final activityCal = _sumTodayActivityCalories(activityAsync.value ?? []);
                     final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
                     
                     if (profile.birthYear != null && profile.gender != null) {
                        final age = DateTime.now().year - profile.birthYear!;
                        if (age > 0) {
                          tdee = calculateDailyCalorieGoal(
                            service: adaptiveService,
                            weightKg: latestWeight,
                            heightCm: profile.heightCm,
                            age: age,
                            gender: profile.gender!,
                            activityCalories: activityCal,
                            goalType: profile.goalType,
                          );
                        }
                     }
                  }
                }

                // Target: 45% of calories from carbs. 1g carb = 4 cal.
                final carbTarget = (tdee * 0.45) / 4;
                final currentCarb = _sumFoodTotals(foodAsync.value ?? []).carb;

                return _MacroProgressCard(
                  title: 'Karbonhidrat',
                  consumed: currentCarb,
                  target: carbTarget,
                  color: const Color(0xFF06B6D4), // Cyan/Blue
                  icon: Icons.grain,
                );
              },
            ),
            
            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),
    );
  }

  FoodTotals _sumFoodTotals(List<FoodEntry> entries) {
    if (entries.isEmpty) {
      return const FoodTotals(cal: 0, protein: 0, carb: 0, fat: 0);
    }
    return entries.fold(
      const FoodTotals(cal: 0, protein: 0, carb: 0, fat: 0),
      (sum, e) => sum.copyWith(
        cal: sum.cal + e.totals.cal,
        protein: sum.protein + e.totals.protein,
        carb: sum.carb + e.totals.carb,
        fat: sum.fat + e.totals.fat,
      ),
    );
  }

  double _sumWater(List<WaterEntry> entries) {
    return entries.fold(0, (sum, e) => sum + (e.ml / 1000.0));
  }

  int _sumTodayActivityMinutes(List<ActivityEntry> entries) {
    return entries.fold(0, (sum, e) => sum + e.durationMin);
  }

  double _sumTodayActivityCalories(List<ActivityEntry> entries) {
    final today = DateTime.now();
    return entries
        .where((entry) => _isSameDay(entry.dateTime.toLocal(), today))
        .fold<double>(0, (sum, entry) => sum + entry.calories);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  _StatData _calculateStatData(List<MeasurementEntry> entries, double? Function(MeasurementEntry) selector) {
    // Sort by date ascending to build history
    final sorted = List<MeasurementEntry>.from(entries)..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    
    // Filter out entries where the specific metric is null
    final validEntries = sorted.where((e) => selector(e) != null).toList();
    
    if (validEntries.isEmpty) {
      return const _StatData(current: null, change: null, history: []);
    }

    final current = selector(validEntries.last);
    final history = validEntries.map((e) => selector(e)!).toList();
    
    // Calculate change from previous entry
    double? change;
    if (validEntries.length > 1) {
      final prev = selector(validEntries[validEntries.length - 2]);
      if (prev != null && current != null) {
        change = current - prev;
      }
    }

    // Determine trend for recent history (last 7 points or all if less)
    final recentHistory = history.length > 7 ? history.sublist(history.length - 7) : history;

    return _StatData(
      current: current,
      change: change,
      history: recentHistory,
    );
  }
}

class _StatData {
  const _StatData({
    required this.current,
    required this.change,
    required this.history,
  });

  final double? current;
  final double? change;
  final List<double> history;
}

class _StatCardShim extends StatelessWidget {
  const _StatCardShim({required this.title, required this.color});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Center(
            child: SizedBox(
               width: 24, 
               height: 24, 
               child: CircularProgressIndicator(strokeWidth: 2, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightGoalCard extends StatelessWidget {
  const _WeightGoalCard({
    required this.current,
    required this.target,
    required this.start,
    required this.progress,
  });

  final double current;
  final double target;
  final double start;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final remaining = (current - target).abs();
    final isLosing = target < start;
    // Calculate progress: 0.0 to 1.0
    // If losing: (start - current) / (start - target)
    // If gaining: (current - start) / (target - start)
    final totalDiff = (target - start).abs();
    final currentDiff = (current - start).abs();
    final rawProgress = totalDiff == 0 ? 0.0 : (currentDiff / totalDiff);
    final progress = rawProgress.clamp(0.0, 1.0);

    return Container(
      height: 180, // Slightly taller for better spacing
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)], // More vibrant blue
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2563EB).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Kilo Hedefi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isLosing 
                        ? 'Verilecek: ${remaining.toStringAsFixed(1)} kg'
                        : 'Alınacak: ${remaining.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Başlangıç: ${start.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background Ring (Translucent White)
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 12,
                    color: Colors.white.withOpacity(0.15),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                // Progress Ring (Solid White)
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    color: Colors.white,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                // Inner Text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Mevcut',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      current.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Hedef ${target.toStringAsFixed(0)}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniProgressRing extends StatelessWidget {
  const _MiniProgressRing({
    required this.label,
    required this.value,
    required this.unit,
    required this.target,
    required this.color,
    required this.progress,
  });

  final String label;
  final String value;
  final String unit;
  final String target;
  final Color color;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF64748B),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 80,
          height: 80,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 6,
                  color: color.withOpacity(0.2),
                  strokeCap: StrokeCap.round,
                ),
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 6,
                  color: color,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    unit,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$value / $target',
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.subtitle,
    required this.changeLabel,
    required this.isPositiveChange,
    required this.color,
    required this.data,
  });

  final String title;
  final String value;
  final String unit;
  final String subtitle;
  final String changeLabel;
  final bool isPositiveChange;
  final Color color;
  final List<double> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Mini Chart
          SizedBox(
            height: 60,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
                    isCurved: true,
                    color: color,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value,
                          style: const TextStyle(
                            color: Color(0xFF1E293B),
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(
                          text: unit,
                          style: const TextStyle(
                            color: Color(0xFF1E293B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    changeLabel,
                    style: TextStyle(
                      color: isPositiveChange ? Colors.green : Colors.red, // Simple color logic
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Değişim',
                    style: TextStyle(
                      color: Color(0xFF94A3B8),
                      fontSize: 10,
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

class _MacroProgressCard extends StatelessWidget {
  const _MacroProgressCard({
    required this.title,
    required this.consumed,
    required this.target,
    required this.color,
    required this.icon,
  });

  final String title;
  final double consumed;
  final double target;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final progress = (consumed / target).clamp(0.0, 1.0);
    final percentage = (progress * 100).toInt();

    return Container(
      height: 160,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: consumed.toStringAsFixed(0),
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const TextSpan(
                  text: 'g',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Hedef: ${target.toStringAsFixed(0)}g',
            style: const TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutExpo,
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.4),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
