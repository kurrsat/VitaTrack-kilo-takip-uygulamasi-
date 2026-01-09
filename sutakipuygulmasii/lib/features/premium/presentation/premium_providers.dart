import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/core/services/purchase_service.dart';
import 'package:water_reminder/core/services/fake_purchase_service.dart';

/// Provider for purchase service
final purchaseServiceProvider = Provider<PurchaseService>((ref) {
  // TODO: Replace with real service when implementing payments
  return FakePurchaseService();
});

/// Provider for premium status
final isPremiumProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(purchaseServiceProvider);
  return service.isPremium();
});

/// Provider for available products
final premiumProductsProvider =
    FutureProvider<List<PremiumProduct>>((ref) async {
  final service = ref.watch(purchaseServiceProvider);
  return service.getProducts();
});

/// Premium features configuration
class PremiumFeatures {
  /// Maximum number of custom cups for free users
  static const int freeCupsLimit = 3;

  /// Maximum number of custom cups for premium users
  static const int premiumCupsLimit = 20; // Unlimited (practical limit)

  /// Check if user can add more cups
  static bool canAddCup(bool isPremium, int currentCount) {
    final limit = isPremium ? premiumCupsLimit : freeCupsLimit;
    return currentCount < limit;
  }

  /// Check if heatmap is available
  static bool hasHeatmap(bool isPremium) {
    return isPremium; // Heatmap is premium-only
  }

  /// Check if streak protect is available
  static bool hasStreakProtect(bool isPremium) {
    return isPremium; // Streak protect is premium-only
  }
}
