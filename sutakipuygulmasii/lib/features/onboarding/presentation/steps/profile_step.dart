import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/features/onboarding/domain/user_profile.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';

/// Profile step - collect user information
class ProfileStep extends ConsumerStatefulWidget {
  const ProfileStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<ProfileStep> createState() => _ProfileStepState();
}

class _ProfileStepState extends ConsumerState<ProfileStep> {
  final _weightController = TextEditingController(text: '70');
  ActivityLevel _selectedActivity = ActivityLevel.moderate;
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _sleepTime = const TimeOfDay(hour: 22, minute: 0);

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kendinden bahset',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Gunluk su hedefini hesaplamamiza yardimci olur',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weight input
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,1}')),
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Kilo (kg) *',
                      hintText: 'Kilonu gir',
                      suffixText: 'kg',
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Activity level
                  const Text(
                    'Aktivite Seviyesi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  ...ActivityLevel.values
                      .map((level) => RadioListTile<ActivityLevel>(
                            title: Text(level.label),
                            subtitle: Text(level.description),
                            value: level,
                            groupValue: _selectedActivity,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedActivity = value);
                              }
                            },
                          )),

                  const SizedBox(height: 24),

                  // Wake and sleep times
                  const Text(
                    'Uyku Duzeni',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Uyanis'),
                          subtitle: Text(_wakeTime.format(context)),
                          trailing: const Icon(Icons.access_time),
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: _wakeTime,
                            );
                            if (time != null) {
                              setState(() => _wakeTime = time);
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Uyku'),
                          subtitle: Text(_sleepTime.format(context)),
                          trailing: const Icon(Icons.access_time),
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: _sleepTime,
                            );
                            if (time != null) {
                              setState(() => _sleepTime = time);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Navigation buttons
          Row(
            children: [
              TextButton(
                onPressed: widget.onBack,
                child: const Text('Geri'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _canProceed() ? _handleNext : null,
                child: const Text('Ileri'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _canProceed() {
    final weight = double.tryParse(_weightController.text);
    return weight != null && weight > 0 && weight < 500;
  }

  void _handleNext() {
    final weight = double.parse(_weightController.text);

    ref.read(onboardingProfileProvider.notifier)
      ..updateWeight(weight)
      ..updateActivityLevel(_selectedActivity)
      ..updateWakeTime(_wakeTime.hour, _wakeTime.minute)
      ..updateSleepTime(_sleepTime.hour, _sleepTime.minute);

    widget.onNext();
  }
}
