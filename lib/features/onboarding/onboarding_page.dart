import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/services/adaptive_goal_service.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _controller = PageController();
  int _index = 0;

  final _nameController = TextEditingController(text: '');
  final _birthYearController = TextEditingController(text: '');
  final _currentWeightController = TextEditingController(text: '');
  final _heightController = TextEditingController(text: '');
  final _goalWeightController = TextEditingController(text: '');
  String? _gender;
  final UnitsSystem _units = UnitsSystem.metric;
  GoalType _goalType = GoalType.lose;
  DateTime _goalDate = DateTime.now().add(const Duration(days: 90));

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _birthYearController.dispose();
    _currentWeightController.dispose();
    _heightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  Future<void> _next() async {
    if (_index < 2) {
      setState(() => _index++);
      await _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _finish() async {
    final prefs = await ref.read(preferencesProvider.future);
    final birthYearText = _birthYearController.text.trim();
    final parsedBirthYear =
        birthYearText.isEmpty ? null : int.tryParse(birthYearText);
    final currentWeightText = _currentWeightController.text.trim();
    final parsedCurrentWeight = double.tryParse(
      currentWeightText.isEmpty ? '' : currentWeightText.replaceAll(',', '.'),
    );
    await prefs.setOnboardingGoal(
      goalType: _goalType.name,
      goalWeight: double.tryParse(_goalWeightController.text) ?? 70,
      goalDate: _goalDate,
      units: _units.name,
      name: _nameController.text.isEmpty ? 'User' : _nameController.text,
      heightCm: double.tryParse(_heightController.text) ?? 170,
      birthYear: parsedBirthYear,
      gender: _gender,
      currentWeightKg: parsedCurrentWeight,
    );
    await prefs.setOnboardingComplete(value: true);
    if (mounted) {
      context.go('/mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
    final caloriePreview = _buildCaloriePreview(adaptiveService);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA), // Light blue
              Color(0xFFFFF3E0), // Light peach
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _OnboardingValue(
                      title: strings.onboardingTitle,
                      subtitle: strings.onboardingSubtitle,
                    ),
                    _OnboardingPermissions(
                      onRequestNotifications: Permission.notification.request,
                      onRequestHealth: ref.read(healthServiceProvider).requestPermissions,
                    ),
                    _OnboardingGoal(
                      nameController: _nameController,
                      birthYearController: _birthYearController,
                      currentWeightController: _currentWeightController,
                      heightController: _heightController,
                      goalWeightController: _goalWeightController,
                      gender: _gender,
  
                      goalType: _goalType,
                      goalDate: _goalDate,
                      caloriePreview: caloriePreview,
  
                      onGoalTypeChanged: (value) => setState(() => _goalType = value),
                      onGoalDateChanged: (value) => setState(() => _goalDate = value),
                      onGenderChanged: (value) => setState(() => _gender = value),
                      onInputChanged: () => setState(() {}),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    if (_index < 2)
                      Expanded(
                        child: TextButton(
                          onPressed: () => context.go('/mode'),
                          child: Text(
                            strings.skip,
                            style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                          ),
                        ),
                      )
                    else
                      const Spacer(),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _index == 2 ? _finish : _next,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                          child: Text(
                            strings.continueLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _CaloriePreview? _buildCaloriePreview(AdaptiveGoalService service) {
    final weightText = _currentWeightController.text.trim();
    final fallbackWeightText = _goalWeightController.text.trim();
    final weight = double.tryParse(
      (weightText.isEmpty ? fallbackWeightText : weightText).replaceAll(',', '.'),
    );
    final height = double.tryParse(_heightController.text.replaceAll(',', '.'));
    final birthYear = int.tryParse(_birthYearController.text.trim());
    final gender = _gender;
    if (weight == null || weight <= 0 || height == null || height <= 0) {
      return null;
    }
    if (birthYear == null || gender == null) {
      return null;
    }
    final age = DateTime.now().year - birthYear;
    if (age <= 0) {
      return null;
    }
    final bmr = service.calculateBmr(
      weightKg: weight,
      heightCm: height,
      age: age,
      gender: gender,
    );
    final tdee = bmr;
    final dailyGoal = tdee + goalOffset(_goalType);
    return _CaloriePreview(bmr: bmr, tdee: tdee, dailyGoal: dailyGoal);
  }
}

class _CaloriePreview {
  const _CaloriePreview({
    required this.bmr,
    required this.tdee,
    required this.dailyGoal,
  });

  final double bmr;
  final double tdee;
  final double dailyGoal;
}

class _OnboardingValue extends StatelessWidget {
  const _OnboardingValue({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          Text(subtitle),
        ],
      ),
    );
  }
}

class _OnboardingPermissions extends StatelessWidget {
  const _OnboardingPermissions({
    required this.onRequestNotifications,
    required this.onRequestHealth,
  });

  final Future<void> Function() onRequestNotifications;
  final Future<void> Function() onRequestHealth;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.permissionsTitle, style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          Text(strings.permissionsSubtitle),
          const SizedBox(height: 24),
          PrimaryButton(
            label: strings.notificationsPermissionCta,
            onPressed: onRequestNotifications,
          ),
          const SizedBox(height: 12),
          SecondaryButton(
            label: strings.healthPermissionCta,
            onPressed: onRequestHealth,
          ),
        ],
      ),
    );
  }
}

class _OnboardingGoal extends StatelessWidget {
  const _OnboardingGoal({
    required this.nameController,
    required this.birthYearController,
    required this.currentWeightController,
    required this.heightController,
    required this.goalWeightController,
    required this.gender,

    required this.goalType,
    required this.goalDate,
    required this.caloriePreview,

    required this.onGoalTypeChanged,
    required this.onGoalDateChanged,
    required this.onGenderChanged,
    required this.onInputChanged,
  });

  final TextEditingController nameController;
  final TextEditingController birthYearController;
  final TextEditingController currentWeightController;
  final TextEditingController heightController;
  final TextEditingController goalWeightController;
  final String? gender;

  final GoalType goalType;
  final DateTime goalDate;
  final _CaloriePreview? caloriePreview;

  final ValueChanged<GoalType> onGoalTypeChanged;
  final ValueChanged<DateTime> onGoalDateChanged;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onInputChanged;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.goalSetupTitle, style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: strings.nameLabel),
              onChanged: (_) => onInputChanged(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: birthYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.birthYearLabel),
              onChanged: (_) => onInputChanged(),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String?>(
              value: gender,
              decoration: InputDecoration(labelText: strings.genderLabel),
              items: [
                DropdownMenuItem(value: 'male', child: Text(strings.genderMale)),
                DropdownMenuItem(value: 'female', child: Text(strings.genderFemale)),
              ],
              onChanged: onGenderChanged,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: currentWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.currentWeightLabel),
              onChanged: (_) => onInputChanged(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.heightLabel),
              onChanged: (_) => onInputChanged(),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<GoalType>(
              value: goalType,
              decoration: InputDecoration(labelText: strings.goalTypeLabel),
              items: GoalType.values
                  .map(
                    (goal) => DropdownMenuItem(
                      value: goal,
                      child: Text(_goalLabel(strings, goal)),
                    ),
                    )
                    .toList(),
              onChanged: (value) => onGoalTypeChanged(value ?? goalType),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: goalWeightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.goalWeightLabel),
              onChanged: (_) => onInputChanged(),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(strings.goalDateLabel),
              subtitle: Text(goalDate.toLocal().toString().split(' ').first),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: goalDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  onGoalDateChanged(picked);
                }
              },
            ),
            const SizedBox(height: 16),
            if (caloriePreview != null)
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.dailyCalorieGoalMessage(
                        caloriePreview!.dailyGoal.toStringAsFixed(0),
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(strings.bmrValue(caloriePreview!.bmr.toStringAsFixed(0))),
                    Text(strings.tdeeValue(caloriePreview!.tdee.toStringAsFixed(0))),
                  ],
                ),
              ),
          ],
        ),
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
}
