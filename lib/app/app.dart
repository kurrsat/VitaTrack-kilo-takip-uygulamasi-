import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/app/router.dart';
import 'package:weightvault/app/theme.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/services/quick_actions_service.dart';
import 'package:weightvault/l10n/app_localizations.dart';
class WeightVaultApp extends ConsumerStatefulWidget {
  const WeightVaultApp({super.key});

  @override
  ConsumerState<WeightVaultApp> createState() => _WeightVaultAppState();
}

class _WeightVaultAppState extends ConsumerState<WeightVaultApp> {
  late final ProviderSubscription<AsyncValue<QuickActionType>> _quickActionSub;

  @override
  void initState() {
    super.initState();
    _quickActionSub =
        ref.listenManual<AsyncValue<QuickActionType>>(quickActionStreamProvider, (previous, next) {
      next.whenData((action) {
        final router = ref.read(appRouterProvider);
        switch (action) {
          case QuickActionType.addWater:
            router.go('/quick-add-water');
        }
      });
    });
  }

  @override
  void dispose() {
    _quickActionSub.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'WeightVault',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
      locale: const Locale('tr'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
