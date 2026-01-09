import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';

/// Goal step - show recommendation and allow manual override
class GoalStep extends ConsumerStatefulWidget {
  const GoalStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<GoalStep> createState() => _GoalStepState();
}

class _GoalStepState extends ConsumerState<GoalStep> {
  late TextEditingController _goalController;
  bool _useCustomGoal = false;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(onboardingProfileProvider);
    final recommended = profile?.calculateRecommendedGoal() ?? 2000;
    _goalController = TextEditingController(text: recommended.toString());
  }

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(onboardingProfileProvider);
    if (profile == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final recommended = profile.calculateRecommendedGoal();
    final glassesPerDay = (recommended / 250).round();

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gunluk Hedefin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Profiline gore onerilen miktar',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),

          // Recommended goal card
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.water_drop,
                    size: 64,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$recommended ml',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Yaklasik $glassesPerDay bardak/gun',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoChip(
                        '${profile.weightKg.toStringAsFixed(0)} kg',
                        Icons.monitor_weight,
                      ),
                      const SizedBox(width: 8),
                      _buildInfoChip(
                        profile.activityLevel.label,
                        Icons.directions_run,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Custom goal option
          SwitchListTile(
            title: const Text('Ozel hedef belirle'),
            subtitle: const Text('Oneriyi degistir'),
            value: _useCustomGoal,
            onChanged: (value) {
              setState(() {
                _useCustomGoal = value;
                if (!value) {
                  _goalController.text = recommended.toString();
                }
              });
            },
          ),

          if (_useCustomGoal) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: 'Gunluk hedef (ml)',
                hintText: 'Ozel hedef gir',
                suffixText: 'ml',
              ),
            ),
          ],

          const Spacer(),

          // Navigation  buttons
          Row(
            children: [
              TextButton(
                onPressed: widget.onBack,
                child: const Text('Geri'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _handleNext,
                child: const Text('Ileri'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  void _handleNext() {
    final goal = _useCustomGoal ? int.tryParse(_goalController.text) : null;
    ref.read(onboardingProfileProvider.notifier).updateDailyGoal(goal);
    widget.onNext();
  }
}
