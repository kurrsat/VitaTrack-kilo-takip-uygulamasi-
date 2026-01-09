import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/presentation/pages/manual_food_page.dart';
import 'package:meallog/features/meal_log/presentation/pages/meal_detail_page.dart';
import 'package:meallog/features/meal_log/presentation/pages/portion_page.dart';
import 'package:meallog/features/meal_log/presentation/pages/search_page.dart';
import 'package:meallog/features/meal_log/presentation/pages/today_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const TodayPage(),
      ),
      GoRoute(
        path: '/search/:mealType',
        builder: (context, state) {
          final mealType = MealTypeX.fromRoute(state.pathParameters['mealType']);
          return SearchPage(mealType: mealType);
        },
      ),
      GoRoute(
        path: '/meal/:mealType',
        builder: (context, state) {
          final mealType = MealTypeX.fromRoute(state.pathParameters['mealType']);
          return MealDetailPage(mealType: mealType);
        },
      ),
      GoRoute(
        path: '/manual/:mealType',
        builder: (context, state) {
          final mealType = MealTypeX.fromRoute(state.pathParameters['mealType']);
          return ManualFoodPage(mealType: mealType);
        },
      ),
      GoRoute(
        path: '/portion',
        builder: (context, state) {
          final args = state.extra! as PortionArgs;
          return PortionPage(args: args);
        },
      ),
    ],
  );
});
