import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/premium/premium_paywall_page.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AddFoodDialog extends ConsumerStatefulWidget {
  const AddFoodDialog({super.key, this.initialMealType});

  final MealType? initialMealType;

  @override
  ConsumerState<AddFoodDialog> createState() => _AddFoodDialogState();
}

class _AddFoodDialogState extends ConsumerState<AddFoodDialog> {
  final _name = TextEditingController();
  final _grams = TextEditingController(text: '100');
  final _cal = TextEditingController();
  final _protein = TextEditingController();
  final _carb = TextEditingController();
  final _fat = TextEditingController();
  final _barcode = TextEditingController();
  late MealType _mealType;
  late bool _mealLocked;
  bool _loading = false;
  double? _baseKcalPer100g;
  double? _baseProteinPer100g;
  double? _baseCarbPer100g;
  double? _baseFatPer100g;
  bool _recalculating = false;
  Timer? _nameDebounce;
  bool _nameLookupInFlight = false;
  bool _isDisposed = false;
  String? _lookupStatus; // null, 'loading', 'success', 'error'

  @override
  void initState() {
    super.initState();
    _mealType = widget.initialMealType ?? MealType.breakfast;
    _mealLocked = widget.initialMealType != null;
  }

  @override
  void dispose() {
    _isDisposed = true;
    _name.dispose();
    _grams.dispose();
    _cal.dispose();
    _protein.dispose();
    _carb.dispose();
    _fat.dispose();
    _barcode.dispose();
    _nameDebounce?.cancel();
    super.dispose();
  }

  Future<void> _lookupByName(String query) async {
    final trimmed = query.trim();
    if (_isDisposed || trimmed.length < 3 || _nameLookupInFlight) return;
    
    if (mounted) {
      setState(() {
        _nameLookupInFlight = true;
        _lookupStatus = 'loading';
      });
    }
    
    try {
      Map<String, dynamic>? product;
      final preferOpenFoodFacts = _looksTurkish(trimmed);
      
      // Debug logging
      print('🔍 FOOD SEARCH DEBUG:');
      print('  Query: "$trimmed"');
      print('  Detected as Turkish: $preferOpenFoodFacts');
      
      if (preferOpenFoodFacts) {
        print('  Trying OpenFoodFacts first...');
        product = await _tryOpenFoodFacts(trimmed)
            .timeout(const Duration(seconds: 30));
        print('  OpenFoodFacts result: ${product != null ? "FOUND" : "NOT FOUND"}');
        
        if (product == null) {
          print('  Trying USDA as fallback...');
          product = await _tryUsda(trimmed)
              .timeout(const Duration(seconds: 30));
          print('  USDA result: ${product != null ? "FOUND" : "NOT FOUND"}');
        }
      } else {
        print('  Trying USDA first...');
        product = await _tryUsda(trimmed)
            .timeout(const Duration(seconds: 30));
        print('  USDA result: ${product != null ? "FOUND" : "NOT FOUND"}');
        
        if (product == null) {
          print('  Trying OpenFoodFacts as fallback...');
          product = await _tryOpenFoodFacts(trimmed)
              .timeout(const Duration(seconds: 30));
          print('  OpenFoodFacts result: ${product != null ? "FOUND" : "NOT FOUND"}');
        }
      }
      
      if (product == null || _isDisposed || !mounted) {
        if (mounted) {
          setState(() => _lookupStatus = null);
          if (product == null) {
             ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Ürün bulunamadı, farklı bir isim deneyin.')),
            );
          }
        }
        return;
      }
      _fillFromProduct(product);
      if (mounted) setState(() => _lookupStatus = 'success');
    } on TimeoutException {
      print('  ⏱️ TIMEOUT ERROR');
      if (mounted) {
        setState(() => _lookupStatus = 'error');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bağlantı çok yavaş veya API yanıt vermiyor')),
        );
      }
    } catch (e) {
      print('  ❌ ERROR: $e');
      if (mounted) {
        setState(() => _lookupStatus = 'error');
      }
    } finally {
      _nameLookupInFlight = false;
    }
  }

  Future<void> _lookupBarcode() async {
    final isPremium = ref.read(premiumServiceProvider).isPremium();
    final isDemoUser = ref.read(currentUserIdProvider) == AppConstants.demoUserId;
    if (!isPremium && !isDemoUser) {
      if (mounted) {
        await Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (_) => const PremiumPaywallPage()),
        );
      }
      return;
    }
    if (!isPremium && isDemoUser && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demo modunda barkod serbest')),
      );
    }
    if (mounted) {
      setState(() => _loading = true);
    }
    try {
      final product =
          await ref.read(openFoodFactsServiceProvider).lookupBarcode(
                _barcode.text.trim(),
              );
      if (product == null || _isDisposed || !mounted) {
        if (product == null && mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Urun bulunamadi')));
        }
        return;
      }
      _fillFromProduct(product);
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  void _fillFromProduct(Map<String, dynamic> product) {
    if (_isDisposed || !mounted) return;
    final nutriments = product['nutriments'] as Map<String, dynamic>? ?? {};
    final nameTr = product['product_name_tr']?.toString() ?? '';
    final name = product['product_name']?.toString() ?? '';
    final chosenName = nameTr.isNotEmpty ? nameTr : name;
    if (_name.text.trim().isEmpty && chosenName.isNotEmpty) {
      _name.text = chosenName;
    }
    final kcalPer100g = _energyKcalPer100g(nutriments);
    _baseKcalPer100g = kcalPer100g;
    _baseProteinPer100g = _nutrimentDouble(nutriments, 'proteins_100g', 'proteins');
    _baseCarbPer100g = _nutrimentDouble(nutriments, 'carbohydrates_100g', 'carbohydrates');
    _baseFatPer100g = _nutrimentDouble(nutriments, 'fat_100g', 'fat');
    if ((kcalPer100g ?? 0) <= 0 && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kalori bulunamadi')),
      );
    }
    if (_baseKcalPer100g == null) _cal.text = '';
    if (_baseProteinPer100g == null) _protein.text = '';
    if (_baseCarbPer100g == null) _carb.text = '';
    if (_baseFatPer100g == null) _fat.text = '';
    _applyGramsToFields();
  }

  double? _energyKcalPer100g(Map<String, dynamic> nutriments) {
    final kcal = _toDouble(nutriments['energy-kcal_100g'] ?? nutriments['energy-kcal']);
    if (kcal != null && kcal > 0) {
      return kcal;
    }
    final kj = _toDouble(
      nutriments['energy-kj_100g'] ?? nutriments['energy-kj'] ?? nutriments['energy_100g'],
    );
    if (kj != null && kj > 0) {
      return kj / 4.184;
    }
    return null;
  }

  double? _nutrimentDouble(Map<String, dynamic> nutriments, String key, String fallback) {
    final value = nutriments[key] ?? nutriments[fallback];
    if (value == null) return null;
    return _toDouble(value);
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  void _applyGramsToFields() {
    if (_recalculating || _isDisposed) return;
    final grams = double.tryParse(_grams.text) ?? 0;
    if (grams <= 0) return;
    if (_baseKcalPer100g == null &&
        _baseProteinPer100g == null &&
        _baseCarbPer100g == null &&
        _baseFatPer100g == null) {
      return;
    }
    _recalculating = true;
    if (_baseKcalPer100g != null) {
      _cal.text = _formatCalories(_baseKcalPer100g! * grams / 100);
    }
    if (_baseProteinPer100g != null) {
      _protein.text = _formatMacro(_baseProteinPer100g! * grams / 100);
    }
    if (_baseCarbPer100g != null) {
      _carb.text = _formatMacro(_baseCarbPer100g! * grams / 100);
    }
    if (_baseFatPer100g != null) {
      _fat.text = _formatMacro(_baseFatPer100g! * grams / 100);
    }
    _recalculating = false;
  }

  void _updateBaseFromField(
    TextEditingController controller,
    void Function(double?) assign,
  ) {
    if (_recalculating) return;
    final grams = double.tryParse(_grams.text) ?? 0;
    if (grams <= 0) return;
    final value = double.tryParse(controller.text);
    if (value == null) return;
    assign(value * 100 / grams);
  }

  String _formatCalories(double value) => value.toStringAsFixed(0);

  String _formatMacro(double value) => value.toStringAsFixed(1);

  bool _looksTurkish(String value) {
    // Check for Turkish-specific characters: ı, ğ, ü, ş, ö, ç (and uppercase variants)
    return value.toLowerCase().contains(RegExp(r'[ığüşöç]'));
  }

  Future<Map<String, dynamic>?> _tryUsda(String query) async {
    try {
      return await ref.read(usdaFoodServiceProvider).searchFirstByName(query);
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> _tryOpenFoodFacts(String query) async {
    try {
      return await ref.read(openFoodFactsServiceProvider).searchFirstByName(query);
    } catch (_) {
      return null;
    }
  }

  Future<void> _save() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    final strings = AppLocalizations.of(context)!;
    final grams = double.tryParse(_grams.text) ?? 100;
    final cal = double.tryParse(_cal.text) ?? 0;
    final protein = double.tryParse(_protein.text) ?? 0;
    final carb = double.tryParse(_carb.text) ?? 0;
    final fat = double.tryParse(_fat.text) ?? 0;
    final item = FoodItem(
      name: _name.text.trim().isEmpty ? strings.foodDefaultName : _name.text.trim(),
      grams: grams,
      cal: cal,
      protein: protein,
      carb: carb,
      fat: fat,
    );
    final totals = FoodTotals(
      cal: cal,
      protein: protein,
      carb: carb,
      fat: fat,
    );
    final entry = FoodEntry(
      id: const Uuid().v4(),
      uid: uid,
      dateTime: DateTime.now().toUtc(),
      mealType: _mealType,
      items: [item],
      totals: totals,
      lastUpdatedAt: DateTime.now().toUtc(),
    );
    await ref.read(foodRepositoryProvider).upsert(entry);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.foodSaved)));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                strings.addFoodTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFEA580C), // Orange
                    ),
              ),
              const SizedBox(height: 24),

              // Search / Name Input
              TextField(
                controller: _name,
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                decoration: InputDecoration(
                  labelText: strings.nameLabel,
                  labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                  hintStyle: const TextStyle(color: Colors.black38),
                  prefixIcon: const Icon(Icons.search, color: Colors.orange),
                  suffixIcon: _lookupStatus == 'loading'
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.orange)),
                          ),
                        )
                      : _lookupStatus == 'success'
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : _lookupStatus == 'error'
                              ? const Icon(Icons.error, color: Colors.red)
                              : null,
                  filled: true,
                  fillColor: Colors.orange.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                onChanged: (value) {
                  _nameDebounce?.cancel();
                  if (mounted) setState(() => _lookupStatus = null);
                  _nameDebounce = Timer(const Duration(milliseconds: 450), () {
                    _lookupByName(value);
                  });
                },
              ),
              const SizedBox(height: 12),

              // Barcode Input (Collapsible/Smaller)
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _barcode,
                      style: const TextStyle(color: Colors.black87, fontSize: 16),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: strings.barcodeLabel,
                        labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        prefixIcon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.download, color: Colors.black87),
                      onPressed: _loading ? null : _lookupBarcode,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Meal Type & Grams Row
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: DropdownButtonFormField<MealType>(
                      value: _mealType,
                      style: const TextStyle(color: Colors.black87, fontSize: 13),
                      decoration: InputDecoration(
                        labelText: strings.mealTypeLabel,
                        labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: MealType.values
                          .map((meal) => DropdownMenuItem(value: meal, child: Text(_mealLabel(strings, meal), style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: _mealLocked ? null : (value) => setState(() => _mealType = value ?? _mealType),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _grams,
                      style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: strings.gramsLabel,
                        labelStyle: const TextStyle(color: Colors.black54, fontSize: 14),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onChanged: (_) => _applyGramsToFields(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),

              // Macros Grid
              Text('Besin Değerleri (Seçilen Gramaj İçin)', style: TextStyle(color: Colors.grey.shade600, fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                   Expanded(child: _buildMacroInput(controller: _cal, label: 'Kcal', color: Colors.orange, icon: Icons.local_fire_department)),
                   const SizedBox(width: 8),
                   Expanded(child: _buildMacroInput(controller: _protein, label: 'Prot', color: Colors.purple, icon: Icons.fitness_center)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                   Expanded(child: _buildMacroInput(controller: _carb, label: 'Carb', color: Colors.blue, icon: Icons.grass)),
                   const SizedBox(width: 8),
                   Expanded(child: _buildMacroInput(controller: _fat, label: 'Fat', color: Colors.amber, icon: Icons.water_drop)),
                ],
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
                          colors: [Color(0xFFff512f), Color(0xFFf09819)], // Orange Gradient
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFf09819).withOpacity(0.3),
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
      ),
    );
  }

  Widget _buildMacroInput({required TextEditingController controller, required String label, required Color color, required IconData icon}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w600),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 16, color: color),
        labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
        filled: true,
        fillColor: color.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        isDense: true,
      ),
      onChanged: (_) {
         if (label == 'Kcal') _updateBaseFromField(_cal, (value) => _baseKcalPer100g = value);
         if (label == 'Prot') _updateBaseFromField(_protein, (value) => _baseProteinPer100g = value);
         if (label == 'Carb') _updateBaseFromField(_carb, (value) => _baseCarbPer100g = value);
         if (label == 'Fat') _updateBaseFromField(_fat, (value) => _baseFatPer100g = value);
      },
    );
  }

  String _mealLabel(AppLocalizations strings, MealType meal) {
    final isTurkish = strings.localeName.startsWith('tr');
    switch (meal) {
      case MealType.breakfast:
        return isTurkish ? 'Kahvalti' : strings.mealBreakfast;
      case MealType.lunch:
        return isTurkish ? 'Ogle Yemegi' : strings.mealLunch;
      case MealType.dinner:
        return isTurkish ? 'Aksam Yemegi' : strings.mealDinner;
      case MealType.snack:
        return isTurkish ? 'Aperatifler' : strings.mealSnack;
    }
  }
}
