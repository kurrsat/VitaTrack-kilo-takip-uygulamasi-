import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class JsonImportPage extends ConsumerStatefulWidget {
  const JsonImportPage({super.key});

  @override
  ConsumerState<JsonImportPage> createState() => _JsonImportPageState();
}

class _JsonImportPageState extends ConsumerState<JsonImportPage> {
  bool _busy = false;

  Future<void> _import() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    setState(() => _busy = true);
    try {
      final strings = AppLocalizations.of(context)!;
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        withData: true,
      );
      if (result == null || result.files.single.bytes == null) return;
      final json = jsonDecode(utf8.decode(result.files.single.bytes!)) as Map<String, dynamic>;
      final bundle = await ref.read(exportImportServiceProvider).importBundle(uid: uid, json: json);
      if (bundle.profile != null) {
        await ref.read(userProfileRepositoryProvider).upsert(bundle.profile!);
      }
      for (final entry in bundle.weights) {
        await ref.read(weightRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.measurements) {
        await ref.read(measurementRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.waters) {
        await ref.read(waterRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.foods) {
        await ref.read(foodRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.customFoods) {
        await ref.read(customFoodRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.fastings) {
        await ref.read(fastingRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.activities) {
        await ref.read(activityRepositoryProvider).upsert(entry);
      }
      for (final entry in bundle.photos) {
        await ref.read(photoRepositoryProvider).upsert(entry);
      }
      await ref.read(crashlyticsProvider).log('import_json');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.importComplete)),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.importJsonTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_busy) LoadingView(label: strings.importingLabel),
            PrimaryButton(label: strings.selectJsonFile, onPressed: _busy ? null : _import),
          ],
        ),
      ),
    );
  }
}
