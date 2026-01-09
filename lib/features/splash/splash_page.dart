import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  late final ProviderSubscription<AsyncValue<AppInitState>> _initSub;

  @override
  void initState() {
    super.initState();
    _initSub = ref.listenManual<AsyncValue<AppInitState>>(appInitProvider, (previous, next) {
      next.whenData((state) {
        unawaited(_handleNavigation(state));
      });
    });
  }

  @override
  void dispose() {
    _initSub.close();
    super.dispose();
  }

  Future<void> _handleNavigation(AppInitState state) async {
    final strings = AppLocalizations.of(context)!;
    final prefs = await ref.read(preferencesProvider.future);
    if (prefs.biometricLockEnabled) {
      final biometric = ref.read(biometricServiceProvider);
      if (await biometric.canCheck()) {
        final ok = await biometric.authenticate(reason: strings.unlockApp);
        if (!ok) {
          return;
        }
      }
    }
    if (!mounted) {
      return;
    }
    // Skip onboarding and mode selection - go directly to auth or dashboard
    if (state.demoMode) {
      context.go('/home/dashboard');
      return;
    }
    if (!state.authenticated) {
      context.go('/auth');
      return;
    }
    context.go('/home/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final init = ref.watch(appInitProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AsyncValueView<AppInitState>(
            value: init,
            data: (_) => LoadingView(label: strings.initializingApp),
          ),
        ),
      ),
    );
  }
}
