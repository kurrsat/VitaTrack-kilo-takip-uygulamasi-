import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/services/adaptive_goal_service.dart';
import 'package:weightvault/features/activity/activity_providers.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _nameController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _heightController = TextEditingController();
  final _goalWeightController = TextEditingController();
  String? _gender;
  UnitsSystem _units = UnitsSystem.metric;
  GoalType _goalType = GoalType.lose;
  DateTime _goalDate = DateTime.now().add(const Duration(days: 90));
  bool _initialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    _birthYearController.dispose();
    _heightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  void _initFromProfile(UserProfile profile) {
    if (_initialized) {
      return;
    }
    _initialized = true;
    _nameController.text = profile.name;
    _birthYearController.text = profile.birthYear?.toString() ?? '';
    _heightController.text = profile.heightCm.toStringAsFixed(0);
    _goalWeightController.text = profile.goalWeight.toStringAsFixed(1);
    _gender = profile.gender;
    _units = profile.units;
    _goalType = profile.goalType;
    _goalDate = profile.goalDate;
  }

  Future<void> _save(UserProfile profile) async {
    final birthYearText = _birthYearController.text.trim();
    final parsedBirthYear = birthYearText.isEmpty ? null : int.tryParse(birthYearText);
    final genderValue = _gender?.trim();
    final updated = profile.copyWith(
      name: _nameController.text.trim(),
      heightCm: double.tryParse(_heightController.text) ?? profile.heightCm,
      goalWeight: double.tryParse(_goalWeightController.text) ?? profile.goalWeight,
      goalType: _goalType,
      units: _units,
      goalDate: _goalDate.toUtc(),
      birthYear: birthYearText.isEmpty ? null : (parsedBirthYear ?? profile.birthYear),
      gender: genderValue == null || genderValue.isEmpty ? null : genderValue,
      lastUpdatedAt: DateTime.now().toUtc(),
    );
    await ref.read(userProfileRepositoryProvider).upsert(updated);
    if (mounted) {
      final strings = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.profileSaved)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(userProfileProvider);
    final weightsAsync = ref.watch(weightEntriesProvider);
    final activitiesAsync = ref.watch(activityEntriesProvider);
    final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.profileTitle),
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return EmptyState(
              title: strings.noProfileTitle,
              message: strings.noProfileMessage,
            );
          }
          _initFromProfile(profile);
          final weights = weightsAsync.value ?? const <WeightEntry>[];
          final latestWeight = weights.isNotEmpty ? weights.last.weightKg : null;
          final birthYear = profile.birthYear;
          final gender = profile.gender;
          final age =
              birthYear == null ? null : DateTime.now().year - birthYear;
          final bmr = latestWeight != null && gender != null && age != null && age > 0
                  ? adaptiveService.calculateBmr(
                      weightKg: latestWeight,
                      heightCm: profile.heightCm,
                      age: age,
                      gender: gender,
                    )
                  : null;
          final activityCalories = activitiesAsync.maybeWhen(
            data: _sumTodayActivityCalories,
            orElse: () => 0.0,
          );
          final storedGoal = profile.tdeeTarget;
          final goalTypeForCalc = storedGoal != null ? profile.goalType : _goalType;
          final tdee = bmr == null ? null : bmr + activityCalories;
          final dailyGoal = tdee == null
              ? storedGoal
              : tdee + goalOffset(goalTypeForCalc);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: strings.nameLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _birthYearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.birthYearLabel),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String?>(
                value: _gender,
                decoration: InputDecoration(labelText: strings.genderLabel),
                items: [
                  DropdownMenuItem(value: 'male', child: Text(strings.genderMale)),
                  DropdownMenuItem(value: 'female', child: Text(strings.genderFemale)),
                  DropdownMenuItem(value: 'other', child: Text(strings.genderOther)),
                ],
                onChanged: (value) => setState(() => _gender = value),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.heightLabel),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<UnitsSystem>(
                value: _units,
                decoration: InputDecoration(labelText: strings.unitsLabel),
                items: UnitsSystem.values
                    .map(
                      (unit) => DropdownMenuItem(
                        value: unit,
                        child: Text(
                          unit == UnitsSystem.metric
                              ? strings.unitsMetric
                              : strings.unitsImperial,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _units = value ?? _units),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<GoalType>(
                value: _goalType,
                decoration: InputDecoration(labelText: strings.goalTypeLabel),
                items: GoalType.values
                    .map(
                      (goal) => DropdownMenuItem(
                        value: goal,
                        child: Text(_goalLabel(strings, goal)),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _goalType = value ?? _goalType),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _goalWeightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.goalWeightLabel),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(strings.goalDateLabel),
                subtitle: Text(_goalDate.toLocal().toString().split(' ').first),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _goalDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() => _goalDate = picked);
                  }
                },
              ),
              if (bmr != null) ...[
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(strings.bmrValue(bmr.toStringAsFixed(0))),
                      if (tdee != null) Text(strings.tdeeValue(tdee.toStringAsFixed(0))),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              strings.dailyCalorieTargetTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: () => _showCalorieGoalDialog(
                              context: context,
                              strings: strings,
                              profile: profile,
                              weightKg: latestWeight ?? profile.goalWeight,
                              activityCalories: activityCalories,
                              adaptiveService: adaptiveService,
                            ),
                            child: Text(strings.editDailyCalorieGoal),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (dailyGoal != null)
                        Text(strings.dailyCalorieGoalMessage(dailyGoal.toStringAsFixed(0)))
                      else
                        Text(strings.calorieGoalMissingInfo),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 16),
              PrimaryButton(label: strings.save, onPressed: () => _save(profile)),
            ],
          );
        },
        loading: () => LoadingView(label: strings.loadingProfile),
        error: (error, _) => ErrorState(title: strings.errorTitle, message: error.toString()),
      ),
    );
  }

  String _goalLabel(AppLocalizations strings, GoalType goal) {
    switch (goal) {
      case GoalType.lose:
        return strings.goalTypeLose;
      case GoalType.gain:
        return strings.goalTypeGain;
      case GoalType.maintain:
        return strings.goalTypeMaintain;
    }
  }

  Future<void> _showCalorieGoalDialog({
    required BuildContext context,
    required AppLocalizations strings,
    required UserProfile profile,
    required double weightKg,
    required double activityCalories,
    required AdaptiveGoalService adaptiveService,
  }) async {
    final birthYear = profile.birthYear;
    final gender = profile.gender;
    if (birthYear == null || gender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.calorieGoalMissingInfo)),
      );
      return;
    }
    final age = DateTime.now().year - birthYear;
    if (age <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.calorieGoalMissingInfo)),
      );
      return;
    }
    final bmr = adaptiveService.calculateBmr(
      weightKg: weightKg,
      heightCm: profile.heightCm,
      age: age,
      gender: gender,
    );
    var selectedGoal = _goalType;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setState) {
            final tdee = bmr + activityCalories;
            final dailyGoal = tdee + goalOffset(selectedGoal);
            return AlertDialog(
              title: Text(strings.dailyCalorieTargetTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<GoalType>(
                      value: selectedGoal,
                      decoration: InputDecoration(
                        labelText: strings.goalTypeLabel,
                      ),
                      items: GoalType.values
                          .map(
                            (goal) => DropdownMenuItem(
                              value: goal,
                              child: Text(_goalLabel(strings, goal)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() => selectedGoal = value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      strings.dailyCalorieGoalMessage(
                        dailyGoal.toStringAsFixed(0),
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(strings.bmrValue(bmr.toStringAsFixed(0))),
                    Text(strings.tdeeValue(tdee.toStringAsFixed(0))),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(strings.cancel),
                ),
                FilledButton(
                  onPressed: () async {
                    final updated = profile.copyWith(
                      goalType: selectedGoal,
                      tdeeTarget: dailyGoal,
                      lastUpdatedAt: DateTime.now().toUtc(),
                    );
                    await ref.read(userProfileRepositoryProvider).upsert(updated);
                    if (mounted) {
                      setState(() => _goalType = selectedGoal);
                    }
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(strings.calorieGoalSaved)),
                      );
                    }
                    if (dialogContext.mounted) {
                      Navigator.of(dialogContext).pop();
                    }
                  },
                  child: Text(strings.save),
                ),
              ],
            );
          },
        );
      },
    );
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
}
