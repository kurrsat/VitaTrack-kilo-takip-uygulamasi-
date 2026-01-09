import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/data/local/seed_food_service.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/services/adaptive_goal_service.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class ProfileSetupPage extends ConsumerStatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  ConsumerState<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends ConsumerState<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _heightController = TextEditingController();
  final _currentWeightController = TextEditingController();
  final _goalWeightController = TextEditingController();
  String? _gender;
  UnitsSystem _units = UnitsSystem.metric;
  GoalType _goalType = GoalType.lose;
  DateTime _goalDate = DateTime.now().add(const Duration(days: 90));
  bool _loading = false;
  bool _draftLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(_loadDraft);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthYearController.dispose();
    _heightController.dispose();
    _currentWeightController.dispose();
    _goalWeightController.dispose();
    super.dispose();
  }

  Future<void> _loadDraft() async {
    if (_draftLoaded) {
      return;
    }
    final prefs = await ref.read(preferencesProvider.future);
    final draft = prefs.onboardingGoalDraft;
    _nameController.text = (draft['name'] as String?) ?? '';
    _birthYearController.text = (draft['birthYear'] as int?)?.toString() ?? '';
    _heightController.text = (draft['heightCm'] as double?)?.toStringAsFixed(0) ?? '';
    _currentWeightController.text =
        (draft['currentWeight'] as double?)?.toStringAsFixed(1) ?? '';
    _goalWeightController.text =
        (draft['goalWeight'] as double?)?.toStringAsFixed(1) ?? '';
    _gender = draft['gender'] as String?;
    _units = UnitsSystem.values.firstWhere(
      (unit) => unit.name == (draft['units'] as String? ?? 'metric'),
      orElse: () => UnitsSystem.metric,
    );
    _goalType = GoalType.values.firstWhere(
      (goal) => goal.name == (draft['goalType'] as String? ?? 'lose'),
      orElse: () => GoalType.lose,
    );
    final goalDateMillis = draft['goalDate'] as int?;
    if (goalDateMillis != null) {
      _goalDate = DateTime.fromMillisecondsSinceEpoch(goalDateMillis, isUtc: true).toLocal();
    }
    _draftLoaded = true;
    if (mounted) {
      setState(() {});
    }
  }

  String? _requiredValidator(String? value, AppLocalizations strings) {
    if (value == null || value.trim().isEmpty) {
      return strings.validationRequired;
    }
    return null;
  }

  String? _numberValidator(String? value, AppLocalizations strings) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return strings.validationRequired;
    }
    final parsed = double.tryParse(trimmed.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return strings.validationInvalidNumber;
    }
    return null;
  }

  String? _birthYearValidator(String? value, AppLocalizations strings) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return strings.validationRequired;
    }
    final parsed = int.tryParse(trimmed);
    final year = DateTime.now().year;
    if (parsed == null || parsed < 1900 || parsed > year) {
      return strings.validationInvalidNumber;
    }
    return null;
  }

  Future<void> _save() async {
    final strings = AppLocalizations.of(context)!;
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final authService = ref.read(authServiceProvider);
    final uid = authService.currentUser?.uid;
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.errorSomethingWentWrong)),
      );
      return;
    }
    setState(() => _loading = true);
    try {
      final birthYear = int.parse(_birthYearController.text.trim());
      final height = double.parse(_heightController.text.trim().replaceAll(',', '.'));
      final currentWeight =
          double.parse(_currentWeightController.text.trim().replaceAll(',', '.'));
      final goalWeight =
          double.parse(_goalWeightController.text.trim().replaceAll(',', '.'));
      final gender = _gender ?? 'other';
      final age = DateTime.now().year - birthYear;
      final dailyGoal = calculateDailyCalorieGoal(
        service: ref.read(adaptiveGoalServiceProvider),
        weightKg: currentWeight,
        heightCm: height,
        age: age,
        gender: gender,
        activityCalories: 0,
        goalType: _goalType,
      );
      final now = DateTime.now().toUtc();
      final profile = UserProfile(
        uid: uid,
        name: _nameController.text.trim(),
        heightCm: height,
        birthYear: birthYear,
        gender: gender,
        units: _units,
        goalType: _goalType,
        goalWeight: goalWeight,
        goalDate: _goalDate.toUtc(),
        tdeeTarget: dailyGoal,
        adaptiveGoalsEnabled: true,
        lastUpdatedAt: now,
        createdAt: now,
      );
      await ref.read(userProfileRepositoryProvider).upsert(profile);
      await ref.read(weightRepositoryProvider).upsert(
            WeightEntry(
              id: const Uuid().v4(),
              uid: uid,
              dateTime: now,
              weightKg: currentWeight,
              lastUpdatedAt: now,
            ),
          );
      await SeedFoodService(ref.read(customFoodRepositoryProvider)).ensureSeedFoods(uid);
      if (!mounted) {
        return;
      }
      context.go('/home/dashboard');
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  _CaloriePreview? _buildPreview(AdaptiveGoalService service) {
    final weight = double.tryParse(
      _currentWeightController.text.trim().replaceAll(',', '.'),
    );
    final height = double.tryParse(
      _heightController.text.trim().replaceAll(',', '.'),
    );
    final birthYear = int.tryParse(_birthYearController.text.trim());
    final gender = _gender;
    if (weight == null || height == null || birthYear == null || gender == null) {
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

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final adaptiveService = ref.watch(adaptiveGoalServiceProvider);
    final preview = _buildPreview(adaptiveService);
    return PopScope(
      canPop: false,
      child: Scaffold(
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 48,
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            strings.profileTitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D1F3C),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            strings.profileSubtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Name
                          _buildInput(
                            controller: _nameController,
                            label: strings.nameLabel,
                            icon: Icons.person_outline,
                            validator: (v) => _requiredValidator(v, strings),
                          ),
                          const SizedBox(height: 16),
                          
                          // Birth Year
                          _buildInput(
                            controller: _birthYearController,
                            label: strings.birthYearLabel,
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.number,
                            validator: (v) => _birthYearValidator(v, strings),
                          ),
                          const SizedBox(height: 16),
                          
                          // Gender
                          DropdownButtonFormField<String?>(
                            value: _gender,
                            decoration: _inputDecoration(strings.genderLabel, Icons.wc),
                            items: [
                              DropdownMenuItem(value: 'male', child: Text(strings.genderMale)),
                              DropdownMenuItem(value: 'female', child: Text(strings.genderFemale)),
                            ],
                            onChanged: (value) => setState(() => _gender = value),
                            validator: (value) => _requiredValidator(value, strings),
                          ),
                          const SizedBox(height: 16),
                          
                          // Weight & Height Row
                          Row(
                            children: [
                              Expanded(
                                child: _buildInput(
                                  controller: _currentWeightController,
                                  label: strings.currentWeightLabel,
                                  icon: Icons.monitor_weight_outlined,
                                  keyboardType: TextInputType.number,
                                  validator: (v) => _numberValidator(v, strings),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildInput(
                                  controller: _heightController,
                                  label: strings.heightLabel,
                                  keyboardType: TextInputType.number,
                                  icon: Icons.height,
                                  validator: (v) => _numberValidator(v, strings),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          
                          // Units
                          DropdownButtonFormField<UnitsSystem>(
                            value: _units,
                            decoration: _inputDecoration(strings.unitsLabel, Icons.straighten),
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
                          const SizedBox(height: 16),
                          
                          // Goal Type
                          DropdownButtonFormField<GoalType>(
                            value: _goalType,
                            decoration: _inputDecoration(strings.goalTypeLabel, Icons.flag_outlined),
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
                          const SizedBox(height: 16),
                          
                          // Goal Weight
                          _buildInput(
                            controller: _goalWeightController,
                            label: strings.goalWeightLabel,
                            icon: Icons.track_changes,
                            keyboardType: TextInputType.number,
                            validator: (v) => _numberValidator(v, strings),
                          ),
                          const SizedBox(height: 16),
                          
                          // Goal Date
                          InkWell(
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
                            borderRadius: BorderRadius.circular(16),
                            child: InputDecorator(
                              decoration: _inputDecoration(strings.goalDateLabel, Icons.event_available),
                              child: Text(
                                _goalDate.toLocal().toString().split(' ').first,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          
                          if (preview != null) ...[
                            const SizedBox(height: 24),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.blue.shade100),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    strings.dailyCalorieGoalMessage(
                                      preview.dailyGoal.toStringAsFixed(0),
                                    ),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue.shade800,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _startPill('BMR: ${preview.bmr.toStringAsFixed(0)}'),
                                      const SizedBox(width: 8),
                                      _startPill('TDEE: ${preview.tdee.toStringAsFixed(0)}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 32),
                          if (_loading)
                            const Center(child: CircularProgressIndicator())
                          else
                            Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6B8DD6), Color(0xFF8E37D7)],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF8E37D7).withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _save,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Text(
                                  strings.save,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _startPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.grey.shade600),
      filled: true,
      fillColor: Colors.grey.shade50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF6B8DD6), width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black87),
      decoration: _inputDecoration(label, icon),
      validator: validator,
      onChanged: (_) => setState(() {}),
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
