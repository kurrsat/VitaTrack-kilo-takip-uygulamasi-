import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/core/services/purchase_service.dart';
import 'package:water_reminder/core/logger/logger.dart';

final _logger = LoggerFactory.getLogger('FakePurchaseService');

/// Fake purchase service for testing
///
/// TODO: Replace with real payment integration
/// This is a stub implementation that stores premium status in Hive
class FakePurchaseService implements PurchaseService {
  static const String _boxName = 'premium_status';
  static const String _premiumKey = 'is_premium';

  @override
  Future<bool> isPremium() async {
    try {
      final box = await Hive.openBox(_boxName);
      return box.get(_premiumKey, defaultValue: false) as bool;
    } catch (e) {
      _logger.error('Failed to check premium status', e);
      return false;
    }
  }

  @override
  Future<bool> purchaseMonthly() async {
    _logger.info('Sahte satin alma: Aylik abonelik');
    // TODO: Implement real payment flow
    return _setPremiumStatus(true);
  }

  @override
  Future<bool> purchaseYearly() async {
    _logger.info('Sahte satin alma: Yillik abonelik');
    // TODO: Implement real payment flow
    return _setPremiumStatus(true);
  }

  @override
  Future<bool> purchaseLifetime() async {
    _logger.info('Sahte satin alma: Omur boyu erisim');
    // TODO: Implement real payment flow
    return _setPremiumStatus(true);
  }

  @override
  Future<bool> restorePurchases() async {
    _logger.info('Sahte satin alma geri yukleme');
    // TODO: Implement real restore logic
    // For now, just return current status
    return isPremium();
  }

  @override
  Future<List<PremiumProduct>> getProducts() async {
    // TODO: Fetch from real store (App Store / Play Store)
    return [
      const PremiumProduct(
        id: 'monthly_sub',
        title: 'Aylik Premium',
        description: 'Tum premium ozelliklere erisim',
        price: '\$2.99/month',
        period: PremiumPeriod.monthly,
      ),
      const PremiumProduct(
        id: 'yearly_sub',
        title: 'Yillik Premium',
        description: 'En iyi teklif - %50 tasarruf!',
        price: '\$17.99/year',
        period: PremiumPeriod.yearly,
      ),
      const PremiumProduct(
        id: 'lifetime',
        title: 'Omur Boyu Erisim',
        description: 'Tek seferlik odeme, sinirsiz erisim',
        price: '\$49.99',
        period: PremiumPeriod.lifetime,
      ),
    ];
  }

  /// Internal method to set premium status (for testing)
  Future<bool> _setPremiumStatus(bool isPremium) async {
    try {
      final box = await Hive.openBox(_boxName);
      await box.put(_premiumKey, isPremium);
      _logger.info('Premium durumu ayarlandi: $isPremium');
      return true;
    } catch (e) {
      _logger.error('Failed to set premium status', e);
      return false;
    }
  }

  /// Helper method for testing - toggle premium status
  Future<void> togglePremium() async {
    final current = await isPremium();
    await _setPremiumStatus(!current);
  }
}
