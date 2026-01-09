/// Premium purchase service interface
///
/// TODO: Implement real payment integration
/// - iOS: in_app_purchase or revenue_cat
/// - Android: in_app_purchase or revenue_cat
/// - Web: Stripe or similar
abstract class PurchaseService {
  /// Checks if user has active premium subscription
  Future<bool> isPremium();

  /// Purchases monthly subscription
  Future<bool> purchaseMonthly();

  /// Purchases yearly subscription
  Future<bool> purchaseYearly();

  /// Purchases lifetime access
  Future<bool> purchaseLifetime();

  /// Restores previous purchases
  Future<bool> restorePurchases();

  /// Gets available products
  Future<List<PremiumProduct>> getProducts();
}

/// Premium product info
class PremiumProduct {
  const PremiumProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.period,
  });

  final String id;
  final String title;
  final String description;
  final String price;
  final PremiumPeriod period;
}

/// Premium subscription periods
enum PremiumPeriod {
  monthly,
  yearly,
  lifetime,
}

extension PremiumPeriodExtension on PremiumPeriod {
  String get displayName {
    switch (this) {
      case PremiumPeriod.monthly:
        return 'Aylik';
      case PremiumPeriod.yearly:
        return 'Yillik';
      case PremiumPeriod.lifetime:
        return 'Omur Boyu';
    }
  }
}
