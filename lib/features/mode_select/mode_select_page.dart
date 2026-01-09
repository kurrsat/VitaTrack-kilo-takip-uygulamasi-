import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/local/demo_seed_service.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class ModeSelectPage extends ConsumerWidget {
  const ModeSelectPage({super.key});

  Future<void> _selectMode(BuildContext context, WidgetRef ref, bool demo) async {
    final prefs = await ref.read(preferencesProvider.future);
    await prefs.setDemoMode(value: demo);
    await prefs.setModeSelected(value: true);
    if (demo) {
      await DemoSeedService(
        prefs: prefs,
        userProfiles: ref.read(userProfileRepositoryProvider),
        weights: ref.read(weightRepositoryProvider),
        measurements: ref.read(measurementRepositoryProvider),
        waters: ref.read(waterRepositoryProvider),
        fastings: ref.read(fastingRepositoryProvider),
        customFoods: ref.read(customFoodRepositoryProvider),
      ).seedIfNeeded();
    }
    if (context.mounted) {
      context.go(demo ? '/home/dashboard' : '/auth');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final flags = ref.watch(featureFlagServiceProvider);
    final firebaseReady = ref.watch(firebaseReadyProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.modeSelectTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.modeSelectHeadline, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            if (flags.demoModeEnabled)
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.demoMode, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(strings.demoModeDescription),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      label: strings.demoModeCta,
                      onPressed: () => _selectMode(context, ref, true),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.normalMode, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(strings.normalModeDescription),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: strings.normalModeCta,
                    onPressed: firebaseReady ? () => _selectMode(context, ref, false) : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
