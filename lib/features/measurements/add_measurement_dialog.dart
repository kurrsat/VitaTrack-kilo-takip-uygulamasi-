import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AddMeasurementDialog extends ConsumerStatefulWidget {
  const AddMeasurementDialog({super.key});

  @override
  ConsumerState<AddMeasurementDialog> createState() => _AddMeasurementDialogState();
}

class _AddMeasurementDialogState extends ConsumerState<AddMeasurementDialog> {
  final _waist = TextEditingController();
  final _hip = TextEditingController();
  final _chest = TextEditingController();
  final _neck = TextEditingController();
  final _arm = TextEditingController();
  final _thigh = TextEditingController();
  final DateTime _dateTime = DateTime.now();

  @override
  void dispose() {
    _waist.dispose();
    _hip.dispose();
    _chest.dispose();
    _neck.dispose();
    _arm.dispose();
    _thigh.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    final entry = MeasurementEntry(
      id: const Uuid().v4(),
      uid: uid,
      dateTime: _dateTime.toUtc(),
      waistCm: double.tryParse(_waist.text) ?? 0,
      hipCm: double.tryParse(_hip.text) ?? 0,
      chestCm: double.tryParse(_chest.text) ?? 0,
      neckCm: double.tryParse(_neck.text) ?? 0,
      armCm: double.tryParse(_arm.text) ?? 0,
      thighCm: double.tryParse(_thigh.text) ?? 0,
      lastUpdatedAt: DateTime.now().toUtc(),
    );
    await ref.read(measurementRepositoryProvider).upsert(entry);
    if (mounted) {
      final strings = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.measurementsSaved)));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(strings.addMeasurementsTitle),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _Field(controller: _waist, label: strings.waistLabel),
            _Field(controller: _hip, label: strings.hipLabel),
            _Field(controller: _chest, label: strings.chestLabel),
            _Field(controller: _neck, label: strings.neckLabel),
            _Field(controller: _arm, label: strings.armLabel),
            _Field(controller: _thigh, label: strings.thighLabel),
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

class _Field extends StatelessWidget {
  const _Field({required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
