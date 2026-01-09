import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AddWeightDialog extends ConsumerStatefulWidget {
  const AddWeightDialog({super.key, this.entry});

  final WeightEntry? entry;

  @override
  ConsumerState<AddWeightDialog> createState() => _AddWeightDialogState();
}

class _AddWeightDialogState extends ConsumerState<AddWeightDialog> {
  late final TextEditingController _weightController;
  late final TextEditingController _noteController;
  late DateTime _dateTime;
  ConditionTag? _condition;
  MoodTag? _mood;

  @override
  void dispose() {
    _weightController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final entry = widget.entry;
    _weightController = TextEditingController(text: entry?.weightKg.toString() ?? '');
    _noteController = TextEditingController(text: entry?.note ?? '');
    _dateTime = entry?.dateTime.toLocal() ?? DateTime.now();
    _condition = entry?.conditionTag;
    _mood = entry?.moodTag;
  }

  Future<void> _save() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) {
      return;
    }
    final weight = double.tryParse(_weightController.text.replaceAll(',', '.'));
    if (weight == null) {
      return;
    }
    final existing = widget.entry;
    WeightEntry? duplicate;
    if (existing == null) {
      final entries = ref.read(weightEntriesProvider).value ?? [];
      for (final entry in entries) {
        final diff = entry.dateTime.difference(_dateTime.toUtc()).inMinutes.abs();
        if (diff <= 120) {
          duplicate = entry;
          break;
        }
      }
    }
    final entry = (existing ??
            duplicate ??
            WeightEntry(
              id: const Uuid().v4(),
              uid: uid,
              dateTime: _dateTime.toUtc(),
              weightKg: weight,
              lastUpdatedAt: DateTime.now().toUtc(),
            ))
        .copyWith(
      uid: uid,
      dateTime: _dateTime.toUtc(),
      weightKg: weight,
      note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      conditionTag: _condition,
      moodTag: _mood,
      lastUpdatedAt: DateTime.now().toUtc(),
    );
    await ref.read(weightRepositoryProvider).upsert(entry);
    await ref.read(crashlyticsProvider).log('add_weight');
    final isPremium = ref.read(premiumServiceProvider).isPremium();
    if (isPremium) {
      final entries = await ref.read(weightRepositoryProvider).watchEntries(uid).first;
      if (entries.isNotEmpty) {
        final settings = ref.read(trendSettingsProvider);
        final trendService = ref.read(trendServiceProvider);
        final trend = trendService.calculateTrend(
          entries,
          method: settings.method,
          alpha: settings.alpha,
          beta: settings.beta,
        );
        final profile = await ref.read(userProfileRepositoryProvider).getProfile(uid);
        final goalWeight = profile?.goalWeight ?? entries.last.weightKg;
        final eta = trendService.estimateEtaDays(entries, trend, goalWeight);
        await ref.read(widgetServiceProvider).updateTodaySummary(
              trend: trend.last,
              etaDays: eta.isFinite ? eta.round() : -1,
            );
      }
    }
    if (mounted) {
      final strings = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.weightSaved)),
      );
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Text(
              widget.entry == null ? strings.addWeight : strings.currentWeightLabel,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 24),

            // Big Weight Input
            Center(
              child: IntrinsicWidth(
                child: TextField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2563EB), // Blue
                  ),
                  decoration: const InputDecoration(
                    hintText: '0.0',
                    suffixText: ' kg',
                    suffixStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Note Input
            TextField(
              controller: _noteController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.note_alt_outlined, color: Colors.grey),
                labelText: strings.noteLabel,
                filled: true,
                fillColor: Colors.grey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 12),

            // Dropdowns
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<ConditionTag>(
                    value: _condition,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      labelText: strings.conditionLabel,
                    ),
                    isExpanded: true,
                    items: ConditionTag.values
                        .map((tag) => DropdownMenuItem(value: tag, child: Text(_conditionLabel(strings, tag), overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (value) => setState(() => _condition = value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<MoodTag>(
                    value: _mood,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      labelText: strings.moodLabel,
                    ),
                    isExpanded: true,
                    items: MoodTag.values
                        .map((tag) => DropdownMenuItem(value: tag, child: Text(_moodLabel(strings, tag), overflow: TextOverflow.ellipsis, maxLines: 1, style: const TextStyle(fontSize: 12))))
                        .toList(),
                    onChanged: (value) => setState(() => _mood = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(strings.cancel, style: const TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF2563EB)], // Blue Gradient
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2563EB).withOpacity(0.3),
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
    );
  }

  String _conditionLabel(AppLocalizations strings, ConditionTag tag) {
    switch (tag) {
      case ConditionTag.morningFasted:
        return strings.conditionMorningFasted;
      case ConditionTag.morningFed:
        return strings.conditionMorningFed;
      case ConditionTag.eveningFasted:
        return strings.conditionEveningFasted;
      case ConditionTag.eveningFed:
        return strings.conditionEveningFed;
    }
  }

  String _moodLabel(AppLocalizations strings, MoodTag tag) {
    switch (tag) {
      case MoodTag.great:
        return strings.moodGreat;
      case MoodTag.ok:
        return strings.moodOk;
      case MoodTag.low:
        return strings.moodLow;
      case MoodTag.stressed:
        return strings.moodStressed;
    }
  }
}

class CurrentWeightDialog extends ConsumerStatefulWidget {
  const CurrentWeightDialog({super.key, this.entry});

  final WeightEntry? entry;

  @override
  ConsumerState<CurrentWeightDialog> createState() => _CurrentWeightDialogState();
}

class _CurrentWeightDialogState extends ConsumerState<CurrentWeightDialog> {
  late final TextEditingController _weightController;

  @override
  void initState() {
    super.initState();
    final entry = widget.entry;
    _weightController = TextEditingController(
      text: entry == null ? '' : entry.weightKg.toStringAsFixed(1),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) {
      return;
    }
    final weight = double.tryParse(_weightController.text.replaceAll(',', '.'));
    if (weight == null) {
      return;
    }
    final now = DateTime.now().toUtc();
    final entry = (widget.entry ??
            WeightEntry(
              id: const Uuid().v4(),
              uid: uid,
              dateTime: now,
              weightKg: weight,
              lastUpdatedAt: now,
            ))
        .copyWith(
      uid: uid,
      dateTime: now,
      weightKg: weight,
      lastUpdatedAt: now,
    );
    await ref.read(weightRepositoryProvider).upsert(entry);
    await ref.read(crashlyticsProvider).log('add_weight');
    if (mounted) {
      final strings = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.weightSaved)),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(strings.currentWeightLabel),
      content: TextField(
        controller: _weightController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: strings.weightLabel),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(strings.cancel)),
        TextButton(onPressed: _save, child: Text(strings.save)),
      ],
    );
  }
}
