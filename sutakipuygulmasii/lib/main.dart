import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/app/providers.dart';
import 'package:water_reminder/app/router.dart';
import 'package:water_reminder/app/theme.dart';
import 'package:water_reminder/core/logger/logger.dart';

final _logger = LoggerFactory.getLogger('WaterReminderApp');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _logger.info('Su Hatirlatici baslatiliyor');

  // Initialize Hive for data persistence
  try {
    await Hive.initFlutter();
  } catch (e) {
    _logger.error('Failed to initialize Hive: $e');
  }

  // Create provider container for initialization
  final container = ProviderContainer();

  // Initialize services
  try {
    tz.initializeTimeZones();
  } catch (e) {
    _logger.error('Failed to initialize timezones: $e');
  }
  
  try {
    final timezoneService = container.read(timezoneServiceProvider);
    await timezoneService.initialize();
  } catch (e) {
     _logger.error('Failed to initialize TimezoneService: $e');
  }

  // Skip notification service on web (not supported)
  if (!kIsWeb) {
    try {
      final notificationService = container.read(notificationServiceProvider);
      await notificationService.initialize();
    } catch (e) {
      _logger.error('Failed to initialize NotificationService: $e');
    }
  }

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const WaterReminderApp(),
    ),
  );
}

class WaterReminderApp extends ConsumerStatefulWidget {
  const WaterReminderApp({super.key});

  @override
  ConsumerState<WaterReminderApp> createState() => _WaterReminderAppState();
}

class _WaterReminderAppState extends ConsumerState<WaterReminderApp>
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
      _logger.info('App resumed - checking timezone');
      // Update timezone when app resumes
      final timezoneService = ref.read(timezoneServiceProvider);
      timezoneService.updateTimezone();
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Su Hatirlatici',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
