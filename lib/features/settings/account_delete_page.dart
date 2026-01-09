import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/services/account_deletion_service.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';
class AccountDeletePage extends ConsumerStatefulWidget {
  const AccountDeletePage({super.key});

  @override
  ConsumerState<AccountDeletePage> createState() => _AccountDeletePageState();
}

class _AccountDeletePageState extends ConsumerState<AccountDeletePage> {
  static const _confirmWord = 'DELETE';
  final _confirmController = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _delete() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null || _confirmController.text.trim() != _confirmWord) {
      return;
    }
    setState(() => _busy = true);
    try {
      final service = AccountDeletionService(
        client: ref.read(firebaseClientProvider),
        auth: FirebaseAuth.instance,
        storage: ref.read(storageServiceProvider),
        userProfiles: ref.read(userProfileRepositoryProvider),
        weights: ref.read(weightRepositoryProvider),
        measurements: ref.read(measurementRepositoryProvider),
        waters: ref.read(waterRepositoryProvider),
        foods: ref.read(foodRepositoryProvider),
        customFoods: ref.read(customFoodRepositoryProvider),
        fastings: ref.read(fastingRepositoryProvider),
        activities: ref.read(activityRepositoryProvider),
        photos: ref.read(photoRepositoryProvider),
        syncLogs: ref.read(syncLogRepositoryProvider),
      );
      await service.deleteAccount(uid);
      await ref.read(crashlyticsProvider).log('account_delete');
      if (mounted) {
        Navigator.of(context).pop();
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
        title: Text(strings.deleteAccountTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.deleteAccountWarning),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmController,
              decoration: InputDecoration(labelText: strings.confirmDeleteLabel(_confirmWord)),
            ),
            const SizedBox(height: 16),
            if (_busy) LoadingView(label: strings.deletingLabel),
            PrimaryButton(label: strings.deleteAccountCta, onPressed: _busy ? null : _delete),
          ],
        ),
      ),
    );
  }
}
