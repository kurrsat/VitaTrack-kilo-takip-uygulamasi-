import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/features/onboarding/domain/user_profile.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';

/// Cups step - setup default cup presets
class CupsStep extends ConsumerStatefulWidget {
  const CupsStep({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  ConsumerState<CupsStep> createState() => _CupsStepState();
}

class _CupsStepState extends ConsumerState<CupsStep> {
  final List<int> _cupSizes = [200, 300, 500];
  int _defaultCup = 200;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hizli Ekle Onayarlari',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Hizli kayit icin varsayilan bardak boyutunu sec',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),

          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: _cupSizes.length,
              itemBuilder: (context, index) {
                final size = _cupSizes[index];
                final isDefault = size == _defaultCup;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _defaultCup = size;
                    });
                  },
                  child: Card(
                    color: isDefault ? Colors.blue.shade50 : null,
                    elevation: isDefault ? 4 : 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_drink,
                          size: 48,
                          color: isDefault ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '$size ml',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDefault ? Colors.blue : null,
                          ),
                        ),
                        if (isDefault) ...[
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Varsayilan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Card(
            color: Colors.amber.shade50,
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.amber),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Bu onayarlari daha sonra ayarlarda degistirebilirsin',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Navigation buttons
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

  void _handleNext() {
    final presets = _cupSizes.map((size) {
      return CupPreset(
        amountMl: size,
        isDefault: size == _defaultCup,
      );
    }).toList();

    ref.read(onboardingProfileProvider.notifier).updateCupPresets(presets);
    widget.onNext();
  }
}
