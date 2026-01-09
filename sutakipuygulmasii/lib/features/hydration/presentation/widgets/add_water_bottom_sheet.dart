import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';
import 'package:water_reminder/features/hydration/presentation/hydration_providers.dart';
import 'package:water_reminder/features/hydration/presentation/widgets/beverage_type_selector.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';
import 'package:water_reminder/features/premium/presentation/premium_providers.dart';

/// Bottom sheet for adding water with cup presets and custom amount
class AddWaterBottomSheet extends ConsumerStatefulWidget {
  const AddWaterBottomSheet({super.key});

  @override
  ConsumerState<AddWaterBottomSheet> createState() =>
      _AddWaterBottomSheetState();
}

class _AddWaterBottomSheetState extends ConsumerState<AddWaterBottomSheet> {
  final _customAmountController = TextEditingController();
  int _customAmount = 200;
  BeverageType _selectedBeverageType = BeverageType.water;

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  Future<void> _addWater(int amount) async {
    final effectiveMl = _selectedBeverageType.calculateEffectiveHydration(amount);
    await addWater(ref, amount, beverageType: _selectedBeverageType);
    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$amount ml ${_selectedBeverageType.label} eklendi '
            '(${_selectedBeverageType.icon} ~ $effectiveMl ml hidratasyon)',
          ),
          duration: const Duration(seconds: 3),
          backgroundColor: _selectedBeverageType.color.withOpacity(0.9),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(userProfileProvider);
    final isPremiumAsync = ref.watch(isPremiumProvider);

    final cups = profileAsync.value?.cupPresets.map((c) => c.amountMl).toList() ?? [200, 300, 500];
    final isPremium = isPremiumAsync.value ?? false;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24.0),
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Geri',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              const SizedBox(height: 8),

              // Title
              Text(
                'Su Ekle',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 24),

              // Beverage Type Selector
              BeverageTypeSelector(
                selectedType: _selectedBeverageType,
                onTypeSelected: (type) {
                  setState(() {
                    _selectedBeverageType = type;
                  });
                },
              ),

              const SizedBox(height: 32),

              // Quick Cup Presets
              Text(
                'Hizli Ekle',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: cups.take(3).map((amount) {
                  return _CupPresetButton(
                    amount: amount,
                    onTap: () => _addWater(amount),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // Custom Amount
              Text(
                'Ozel Miktar',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  // Minus button
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _customAmount = (_customAmount - 50).clamp(50, 5000);
                        _customAmountController.text = _customAmount.toString();
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    iconSize: 32,
                  ),

                  const SizedBox(width: 8),

                  // Amount input
                  Expanded(
                    child: TextField(
                      controller: _customAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        suffix: const Text('ml'),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        final amount = int.tryParse(value) ?? 200;
                        setState(() {
                          _customAmount = amount.clamp(1, 5000);
                        });
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Plus button
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _customAmount = (_customAmount + 50).clamp(50, 5000);
                        _customAmountController.text = _customAmount.toString();
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                    iconSize: 32,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Effective hydration info
              EffectiveHydrationInfo(
                amountMl: _customAmount,
                beverageType: _selectedBeverageType,
              ),

              const SizedBox(height: 16),

              // Add button
              ElevatedButton(
                onPressed: () => _addWater(_customAmount),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedBeverageType.color,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _selectedBeverageType.icon,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$_customAmount ml ${_selectedBeverageType.label} ekle',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Cup Management
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bardaklarim',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      final canAdd = PremiumFeatures.canAddCup(
                        isPremium,
                        cups.length,
                      );

                      if (!canAdd) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Premium Ozellik'),
                            content: const Text(
                              'Ucretsiz kullanicilar en fazla 3 bardak ekleyebilir. '
                              'Sinirsiz bardak icin Premiuma gecin!',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Tamam'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // TODO: Show add cup dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Bardak yonetimi yakinda!'),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Bardak Ekle'),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // All cups list
              ...cups.map((amount) {
                return ListTile(
                  leading: const Icon(Icons.local_drink),
                  title: Text('$amount ml'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle, color: Colors.blue),
                        onPressed: () => _addWater(amount),
                        tooltip: 'Hizli ekle',
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _CupPresetButton extends StatelessWidget {
  final int amount;
  final VoidCallback onTap;

  const _CupPresetButton({
    required this.amount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.blue.shade200,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.local_drink,
              size: 36,
              color: Colors.blue.shade700,
            ),
            const SizedBox(height: 8),
            Text(
              '$amount ml',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
