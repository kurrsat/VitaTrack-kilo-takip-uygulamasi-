import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/activity/activity_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AddActivityDialog extends ConsumerStatefulWidget {
  const AddActivityDialog({super.key});

  @override
  ConsumerState<AddActivityDialog> createState() => _AddActivityDialogState();
}

class ActivityPreset {
  const ActivityPreset({
    required this.label,
    required this.kcalPerMinute,
  });

  final String label;
  final double? kcalPerMinute;
}

class _AddActivityDialogState extends ConsumerState<AddActivityDialog> {
  final _duration = TextEditingController(text: '30');
  final _calories = TextEditingController(text: '200');
  bool _initialized = false;
  late ActivityPreset _selectedPreset;

  static const List<ActivityPreset> _presets = [
    ActivityPreset(label: 'Kardiyo', kcalPerMinute: 8),
    ActivityPreset(label: 'Kosu', kcalPerMinute: 10),
    ActivityPreset(label: 'Yuruyus', kcalPerMinute: 5),
    ActivityPreset(label: 'Bisiklet', kcalPerMinute: 7),
    ActivityPreset(label: 'Yuzme', kcalPerMinute: 9),
    ActivityPreset(label: 'Spor', kcalPerMinute: 6),
  ];

  @override
  void dispose() {
    _duration.dispose();
    _calories.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) {
      return;
    }
    _selectedPreset = _presets.first;
    _applyDurationChange();
    _initialized = true;
  }

  Future<void> _save() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    final entry = ActivityEntry(
      id: const Uuid().v4(),
      uid: uid,
      dateTime: DateTime.now().toUtc(),
      type: _selectedPreset.label,
      durationMin: int.tryParse(_duration.text) ?? 0,
      calories: double.tryParse(_calories.text) ?? 0,
      source: ActivitySource.manual,
      lastUpdatedAt: DateTime.now().toUtc(),
    );
    await ref.read(activityRepositoryProvider).upsert(entry);
    await _updateDailyGoalAfterActivity(entry);
    if (mounted) {
      final strings = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.activitySaved)));
      Navigator.of(context).pop();
    }
  }

  void _applyDurationChange() {
    final duration = int.tryParse(_duration.text) ?? 0;
    final perMinute = _selectedPreset.kcalPerMinute ?? 0;
    final calories = duration <= 0 ? 0 : perMinute * duration;
    _calories.text = calories.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              strings.addActivityTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFDC2626), // Red
                  ),
            ),
            const SizedBox(height: 24),

            // Activity Type Dropdown
            DropdownButtonFormField<ActivityPreset>(
              value: _selectedPreset,
              decoration: InputDecoration(
                labelText: strings.activityTypeLabel,
                prefixIcon: const Icon(Icons.fitness_center, color: Colors.red),
                filled: true,
                fillColor: Colors.red.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              items: _presets
                  .map(
                    (preset) => DropdownMenuItem(
                      value: preset,
                      child: Text(preset.label),
                    ),
                  )
                  .toList(),
              onChanged: (preset) {
                if (preset == null) return;
                setState(() {
                  _selectedPreset = preset;
                });
                _applyDurationChange();
              },
            ),
            const SizedBox(height: 16),

            // Duration Input
            TextField(
              controller: _duration,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                labelText: strings.activityDurationLabel,
                suffixText: 'dk',
                prefixIcon: const Icon(Icons.timer, color: Colors.red),
                filled: true,
                fillColor: Colors.red.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onChanged: (_) => _applyDurationChange(),
            ),
            const SizedBox(height: 16),

            // Calories (Read-only Result)
            TextField(
              controller: _calories,
              keyboardType: TextInputType.number,
              readOnly: true,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFDC2626)),
              decoration: InputDecoration(
                labelText: strings.caloriesLabel,
                suffixText: 'kcal',
                prefixIcon: const Icon(Icons.local_fire_department, color: Colors.red),
                filled: true,
                fillColor: Colors.red.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: Text(strings.cancel, style: const TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)], // Red Gradient
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDC2626).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(
                        strings.save,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateDailyGoalAfterActivity(ActivityEntry entry) async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) {
      return;
    }
    final profileRepo = ref.read(userProfileRepositoryProvider);
    final profile = await profileRepo.getProfile(uid);
    if (profile == null) {
      return;
    }
    final birthYear = profile.birthYear;
    final gender = profile.gender;
    if (birthYear == null || gender == null) {
      return;
    }
    final age = DateTime.now().year - birthYear;
    if (age <= 0) {
      return;
    }
    final weights = ref.read(weightEntriesProvider).value ?? const <WeightEntry>[];
    final weightKg = weights.isNotEmpty ? weights.last.weightKg : profile.goalWeight;
    final existing = ref.read(activityEntriesProvider).value ?? const <ActivityEntry>[];
    final now = DateTime.now();
    final todayEntries = existing
        .where((value) => _isSameDay(value.dateTime.toLocal(), now))
        .toList();
    if (!todayEntries.any((value) => value.id == entry.id)) {
      todayEntries.add(entry);
    }
    final activityCalories =
        todayEntries.fold<double>(0, (sum, value) => sum + value.calories);
    final dailyGoal = calculateDailyCalorieGoal(
      service: ref.read(adaptiveGoalServiceProvider),
      weightKg: weightKg,
      heightCm: profile.heightCm,
      age: age,
      gender: gender,
      activityCalories: activityCalories,
      goalType: profile.goalType,
    );
    await profileRepo.upsert(
      profile.copyWith(
        tdeeTarget: dailyGoal,
        lastUpdatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
