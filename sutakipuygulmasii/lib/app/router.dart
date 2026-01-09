import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/app/exit_handler.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_page.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';
import 'package:water_reminder/features/hydration/presentation/hydration_home_page.dart';
import 'package:water_reminder/features/premium/presentation/premium_paywall_page.dart';
import 'package:water_reminder/features/reminders/presentation/reminders_page.dart';
import 'package:water_reminder/features/reminders/presentation/test_notification_page.dart';
import 'package:water_reminder/features/settings/presentation/settings_pages.dart';
import 'package:water_reminder/features/stats/presentation/stats_page.dart';

class Routes {
  Routes._();

  static const String onboarding = '/onboarding';
  static const String home = '/';
  static const String hydration = '/hydration';
  static const String reminders = '/reminders';
  static const String stats = '/stats';
  static const String settings = '/settings';
  static const String premium = '/premium';
  static const String testNotification = '/test-notification';

  // Settings sub-pages
  static const String profileEdit = '/settings/profile';
  static const String goalSettings = '/settings/goal';
  static const String reminderSettings = '/settings/reminders';
  static const String cupsSettings = '/settings/cups';
  static const String dataManagement = '/settings/data';
  static const String help = '/settings/help';
  static const String privacy = '/settings/privacy';
}

/// Router provider with first-run redirect
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // Check if this is first run
      final isFirstRun = await ref.read(isFirstRunProvider.future);

      // If first run and not on onboarding, redirect to onboarding
      if (isFirstRun && state.matchedLocation != Routes.onboarding) {
        return Routes.onboarding;
      }

      return null; // No redirect needed
    },
    routes: [
      GoRoute(
        path: Routes.onboarding,
        name: 'onboarding',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const OnboardingPage(),
        ),
      ),
      GoRoute(
        path: Routes.home,
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        path: Routes.hydration,
        name: 'hydration',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HydrationPage(),
        ),
      ),
      GoRoute(
        path: Routes.reminders,
        name: 'reminders',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RemindersPage(),
        ),
      ),
      GoRoute(
        path: Routes.stats,
        name: 'stats',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const StatsPage(),
        ),
      ),
      GoRoute(
        path: Routes.settings,
        name: 'settings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SettingsPage(),
        ),
      ),
      GoRoute(
        path: Routes.premium,
        name: 'premium',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const PremiumPage(),
        ),
      ),
      GoRoute(
        path: Routes.testNotification,
        name: 'testNotification',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const TestNotificationPage(),
        ),
      ),
      // Settings sub-pages
      GoRoute(
        path: Routes.profileEdit,
        name: 'profileEdit',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Scaffold(
            appBar: null,
            body: Center(child: Text('Profil Duzenleme - Yakinda')),
          ),
        ),
      ),
      GoRoute(
        path: Routes.goalSettings,
        name: 'goalSettings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Scaffold(
            appBar: null,
            body: Center(child: Text('Hedef Ayarlari - Yakinda')),
          ),
        ),
      ),
      GoRoute(
        path: Routes.reminderSettings,
        name: 'reminderSettings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Scaffold(
            appBar: null,
            body: Center(child: Text('Hatirlatici Ayarlari - Yakinda')),
          ),
        ),
      ),
      GoRoute(
        path: Routes.cupsSettings,
        name: 'cupsSettings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const QuickAddSettingsPage(),
        ),
      ),
      GoRoute(
        path: Routes.dataManagement,
        name: 'dataManagement',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const DataManagementPage(),
        ),
      ),
      GoRoute(
        path: Routes.help,
        name: 'help',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HelpPage(),
        ),
      ),
      GoRoute(
        path: Routes.privacy,
        name: 'privacy',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const PrivacyPage(),
        ),
      ),
    ],
  );
});

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tiles = [
      const _NavTileData(
        title: 'Hatirlaticilar',
        subtitle: 'Bildirimleri planla',
        icon: Icons.notifications_active,
        accent: Color(0xFFFFC266),
        route: Routes.reminders,
      ),
      const _NavTileData(
        title: 'Istatistikler',
        subtitle: 'Haftalik trendleri gor',
        icon: Icons.show_chart,
        accent: Color(0xFF78C7FF),
        route: Routes.stats,
      ),
      const _NavTileData(
        title: 'Ayarlar',
        subtitle: 'Uygulamayi ozellestir',
        icon: Icons.settings,
        accent: Color(0xFFB0BEC5),
        route: Routes.settings,
      ),
      const _NavTileData(
        title: 'Premium',
        subtitle: 'Ek ozelliklerin kilidini ac',
        icon: Icons.workspace_premium,
        accent: Color(0xFFFFD36A),
        route: Routes.premium,
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: const Text('Su Hatirlatici'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          const _HomeBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Takipte kal',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Nereye gidecegini sec',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _HeroCard(
                    onTap: () => context.go(Routes.hydration),
                  ),
                  const SizedBox(height: 20),
                  const _SectionHeader(
                    title: 'Hizli erisim',
                    subtitle: 'Sik kullandigin bolumlere git',
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final itemWidth = (constraints.maxWidth - 12) / 2;
                      return Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          for (final tile in tiles)
                            SizedBox(
                              width: itemWidth,
                              child: _NavTile(
                                data: tile,
                                onTap: () => context.go(tile.route),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0B4DB8),
                Color(0xFF1A7FE8),
              ],
            ),
          ),
        ),
        Positioned(
          top: -50,
          right: -30,
          child: _GlowOrb(
            size: 160,
            color: Colors.white12,
          ),
        ),
        Positioned(
          top: 180,
          left: -40,
          child: _GlowOrb(
            size: 120,
            color: Color(0x14FFFFFF),
          ),
        ),
        Positioned(
          bottom: -40,
          right: -20,
          child: _GlowOrb(
            size: 180,
            color: Color(0x14FFFFFF),
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _GlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeroBadge(),
                const SizedBox(height: 10),
                Text(
        'Su Takibi',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
        'Iceceklerini kaydet ve duzenli kal.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.water_drop),
                  label: const Text('Takibi ac'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Colors.white,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBadge extends StatelessWidget {
  const _HeroBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        'Bugun',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class _NavTileData {
  const _NavTileData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.route,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final String route;
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.data,
    required this.onTap,
  });

  final _NavTileData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: data.accent.withOpacity(0.22),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: data.accent.withOpacity(0.55),
                  ),
                ),
                child: Icon(
                  data.icon,
                  size: 20,
                  color: data.accent,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                data.title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                data.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class HydrationPage extends StatelessWidget {
  const HydrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HydrationHomePage();
  }
}

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatsPageContent();
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPageContent();
  }
}

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PremiumPaywallPage();
  }
}
