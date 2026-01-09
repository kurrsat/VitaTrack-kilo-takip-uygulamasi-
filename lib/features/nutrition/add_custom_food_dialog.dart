import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AddCustomFoodDialog extends ConsumerStatefulWidget {
  const AddCustomFoodDialog({super.key});

  @override
  ConsumerState<AddCustomFoodDialog> createState() => _AddCustomFoodDialogState();
}

class _AddCustomFoodDialogState extends ConsumerState<AddCustomFoodDialog> {
  final _nameTr = TextEditingController();
  final _nameEn = TextEditingController();
  final _barcode = TextEditingController();
  final _cal = TextEditingController();
  final _protein = TextEditingController();
  final _carb = TextEditingController();
  final _fat = TextEditingController();

  @override
  void dispose() {
    _nameTr.dispose();
    _nameEn.dispose();
    _barcode.dispose();
    _cal.dispose();
    _protein.dispose();
    _carb.dispose();
    _fat.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    final strings = AppLocalizations.of(context)!;
    final food = CustomFood(
      id: const Uuid().v4(),
      uid: uid,
      nameTr: _nameTr.text.trim().isEmpty ? strings.customFoodDefaultTr : _nameTr.text.trim(),
      nameEn: _nameEn.text.trim().isEmpty ? strings.customFoodDefaultEn : _nameEn.text.trim(),
      barcode: _barcode.text.trim().isEmpty ? null : _barcode.text.trim(),
      cal: double.tryParse(_cal.text) ?? 0,
      protein: double.tryParse(_protein.text) ?? 0,
      carb: double.tryParse(_carb.text) ?? 0,
      fat: double.tryParse(_fat.text) ?? 0,
      lastUpdatedAt: DateTime.now().toUtc(),
    );
    await ref.read(customFoodRepositoryProvider).upsert(food);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.customFoodSaved)));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(strings.customFoodTitle),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: _nameTr, decoration: InputDecoration(labelText: strings.nameTrLabel)),
            const SizedBox(height: 8),
            TextField(controller: _nameEn, decoration: InputDecoration(labelText: strings.nameEnLabel)),
            const SizedBox(height: 8),
            TextField(controller: _barcode, decoration: InputDecoration(labelText: strings.barcodeOptionalLabel)),
            const SizedBox(height: 8),
            TextField(
              controller: _cal,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.caloriesLabel),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _protein,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.proteinLabel),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _carb,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.carbLabel),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _fat,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: strings.fatLabel),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(strings.cancel)),
        TextButton(onPressed: _save, child: Text(strings.save)),
      ],
    );
  }
}
