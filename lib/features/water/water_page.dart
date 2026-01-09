import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/app/exit_handler.dart' as water_exit;
import 'package:water_reminder/app/providers.dart' as water_providers;
import 'package:water_reminder/app/router.dart' as water_router;
import 'package:water_reminder/app/theme.dart' as water_theme;
import 'package:water_reminder/features/hydration/presentation/hydration_providers.dart'
    as water_hydration;
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class WaterPage extends ConsumerStatefulWidget {
  const WaterPage({super.key});

  @override
  ConsumerState<WaterPage> createState() => _WaterPageState();
}

class _WaterPageState extends ConsumerState<WaterPage> {
  static bool _hiveInitialized = false;
  late final ProviderContainer _container;
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _container = ProviderContainer();
    _initFuture = _initWaterModule();
    water_exit.WaterExitHandler.onExit = () async {
      await _syncWaterLogsToWeightVault();
      if (!mounted) {
        return;
      }
      final popped = await Navigator.of(context).maybePop();
      if (!popped && mounted) {
        context.go('/home/dashboard');
      }
    };
  }

  Future<void> _initWaterModule() async {
    if (!_hiveInitialized) {
      try {
        await Hive.initFlutter();
        _hiveInitialized = true;
      } catch (e) {
        // Find if already initialized or other error
        debugPrint('Hive init error (ignoring if just duplicate): $e');
        _hiveInitialized = true; // Assume initialized if it failed due to being already done
      }
    }
    final timezoneService = _container.read(water_providers.timezoneServiceProvider);
    await timezoneService.initialize();
    if (!kIsWeb) {
      final notificationService =
          _container.read(water_providers.notificationServiceProvider);
      await notificationService.initialize();
    }
  }

  Future<void> _syncWaterLogsToWeightVault() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) {
      return;
    }
    final intakeRepository =
        _container.read(water_hydration.intakeLogRepositoryProvider);
    final logs = await intakeRepository.getTodayLogs();
    if (logs.isEmpty) {
      return;
    }
    final waterRepo = ref.read(waterRepositoryProvider);
    final now = DateTime.now().toUtc();
    for (final log in logs) {
      final entry = WaterEntry(
        id: 'wr_${log.id}',
        uid: uid,
        date: log.timestampUtc,
        ml: log.amountMl,
        lastUpdatedAt: now,
      );
      await waterRepo.upsert(entry);
    }
  }

  @override
  void dispose() {
    if (water_exit.WaterExitHandler.onExit != null) {
      water_exit.WaterExitHandler.onExit = null;
    }
    _container.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const LoadingView();
        }
        if (snapshot.hasError) {
          return ErrorState(
            title: strings.errorSomethingWentWrong,
            message: snapshot.error.toString(),
          );
        }
        final waterRouter = _container.read(water_router.routerProvider);
        return PopScope(
          canPop: !waterRouter.canPop(),
          onPopInvokedWithResult: (didPop, _) {
            if (didPop) {
              return;
            }
            if (waterRouter.canPop()) {
              waterRouter.pop();
            }
          },
          child: UncontrolledProviderScope(
            container: _container,
            child: const _WaterAppHost(),
          ),
        );
      },
    );
  }
}

class _WaterAppHost extends ConsumerStatefulWidget {
  const _WaterAppHost();

  @override
  ConsumerState<_WaterAppHost> createState() => _WaterAppHostState();
}

class _WaterAppHostState extends ConsumerState<_WaterAppHost>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(water_providers.timezoneServiceProvider).updateTimezone();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(water_router.routerProvider);
    return MaterialApp.router(
      title: 'Water Reminder',
      debugShowCheckedModeBanner: false,
      theme: water_theme.AppTheme.lightTheme,
      darkTheme: water_theme.AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
