import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/features/activity/activity_page.dart';
import 'package:weightvault/features/analytics/analytics_page.dart';
import 'package:weightvault/features/auth/auth_page.dart';
import 'package:weightvault/features/auth/profile_setup_page.dart';
import 'package:weightvault/features/dashboard/dashboard_page.dart';
import 'package:weightvault/features/data_export_import/data_export_import_page.dart';
import 'package:weightvault/features/data_export_import/import_json_page.dart';
import 'package:weightvault/features/insights/insights_page.dart';
import 'package:weightvault/features/insights/weekly_report_page.dart';
import 'package:weightvault/features/log/log_page.dart';
import 'package:weightvault/features/measurements/measurements_page.dart';
import 'package:weightvault/features/mode_select/mode_select_page.dart';
import 'package:weightvault/features/nutrition/nutrition_page.dart';
import 'package:weightvault/features/onboarding/onboarding_page.dart';

import 'package:weightvault/features/photos/photos_page.dart';
import 'package:weightvault/features/premium/premium_paywall_page.dart';
import 'package:weightvault/features/reports/reports_page.dart';
import 'package:weightvault/features/settings/account_delete_page.dart';
import 'package:weightvault/features/settings/analysis_settings_page.dart';
import 'package:weightvault/features/settings/privacy_page.dart';
import 'package:weightvault/features/settings/profile_page.dart';
import 'package:weightvault/features/settings/settings_page.dart';
import 'package:weightvault/features/settings/terms_page.dart';
import 'package:weightvault/features/shortcuts/quick_add_water_page.dart';
import 'package:weightvault/features/shortcuts/quick_add_weight_page.dart';
import 'package:weightvault/features/splash/splash_page.dart';
import 'package:weightvault/features/water/water_page.dart';
import 'package:weightvault/features/widgets/home_shell.dart';
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const AuthPage(), // Redirect to Auth instead
      ),
      GoRoute(
        path: '/mode',
        builder: (context, state) => const AuthPage(), // Redirect to Auth instead
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: '/profile-setup',
        builder: (context, state) => const ProfileSetupPage(),
      ),
      GoRoute(
        path: '/quick-add-weight',
        builder: (context, state) => const QuickAddWeightPage(),
      ),
      GoRoute(
        path: '/quick-add-water',
        builder: (context, state) => const QuickAddWaterPage(),
      ),

      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return HomeShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/dashboard',
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/log',
                builder: (context, state) => const LogPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/reports',
                builder: (context, state) => const ReportsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/photos',
                builder: (context, state) => const PhotosPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home/settings',
                builder: (context, state) => const SettingsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
      GoRoute(path: '/measurements', builder: (context, state) => const MeasurementsPage()),
      GoRoute(path: '/nutrition', builder: (context, state) => const NutritionPage()),
      GoRoute(path: '/water', builder: (context, state) => const WaterPage()),
      GoRoute(path: '/activity', builder: (context, state) => const ActivityPage()),
      GoRoute(path: '/insights', builder: (context, state) => const InsightsPage()),
      GoRoute(path: '/weekly-report', builder: (context, state) => const WeeklyReportPage()),
      GoRoute(path: '/premium', builder: (context, state) => const PremiumPaywallPage()),
      GoRoute(path: '/export', builder: (context, state) => const DataExportImportPage()),
      GoRoute(path: '/import-json', builder: (context, state) => const JsonImportPage()),
      GoRoute(path: '/privacy', builder: (context, state) => const PrivacyPage()),
      GoRoute(path: '/terms', builder: (context, state) => const TermsPage()),
      GoRoute(
        path: '/analysis-settings',
        builder: (context, state) => const AnalysisSettingsPage(),
      ),
      GoRoute(path: '/account-delete', builder: (context, state) => const AccountDeletePage()),
    ],
  );
});
