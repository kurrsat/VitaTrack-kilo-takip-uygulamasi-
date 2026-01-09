import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/usecases/search_foods.dart';

class SearchState {
  const SearchState({
    required this.query,
    required this.items,
    required this.isLoading,
    required this.errorMessage,
    required this.fromCache,
    required this.isStale,
    required this.isFallback,
  });

  final String query;
  final List<FoodSearchItem> items;
  final bool isLoading;
  final String? errorMessage;
  final bool fromCache;
  final bool isStale;
  final bool isFallback;

  SearchState copyWith({
    String? query,
    List<FoodSearchItem>? items,
    bool? isLoading,
    String? errorMessage,
    bool? fromCache,
    bool? isStale,
    bool? isFallback,
  }) {
    return SearchState(
      query: query ?? this.query,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      fromCache: fromCache ?? this.fromCache,
      isStale: isStale ?? this.isStale,
      isFallback: isFallback ?? this.isFallback,
    );
  }

  static SearchState initial() {
    return const SearchState(
      query: '',
      items: [],
      isLoading: false,
      errorMessage: null,
      fromCache: false,
      isStale: false,
      isFallback: false,
    );
  }
}

class SearchController extends StateNotifier<SearchState> {
  SearchController({required SearchFoodsUseCase searchFoods})
      : _searchFoods = searchFoods,
        super(SearchState.initial());

  final SearchFoodsUseCase _searchFoods;
  Timer? _debounce;

  void updateQuery(String query) {
    state = state.copyWith(query: query);
    _debounce?.cancel();
    if (query.trim().length < 2) {
      state = state.copyWith(
        items: [],
        isLoading: false,
        errorMessage: null,
        fromCache: false,
        isStale: false,
        isFallback: false,
      );
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: null);
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      final result = await _searchFoods.call(query.trim());
      result.when(
        success: (data) {
          state = state.copyWith(
            items: data.items,
            isLoading: false,
            fromCache: data.fromCache,
            isStale: data.isStale,
            isFallback: data.isFallback,
            errorMessage: null,
          );
        },
        failure: (error) {
          state = state.copyWith(isLoading: false, errorMessage: error.message);
        },
      );
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
