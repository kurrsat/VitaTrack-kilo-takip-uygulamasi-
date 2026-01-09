import 'package:purchases_flutter/purchases_flutter.dart';
class PremiumService {
  CustomerInfo? _customerInfo;
  bool _configured = false;

  CustomerInfo? get customerInfo => _customerInfo;
  bool get isConfigured => _configured;

  Future<void> init({required String apiKey, String? appUserId}) async {
    await Purchases.configure(PurchasesConfiguration(apiKey)..appUserID = appUserId);
    _customerInfo = await Purchases.getCustomerInfo();
    _configured = true;
  }

  Future<Offerings> getOfferings() => Purchases.getOfferings();

  Future<CustomerInfo> purchasePackage(Package package) async {
    final info = await Purchases.purchasePackage(package);
    _customerInfo = info;
    return info;
  }

  Future<CustomerInfo> restorePurchases() async {
    final info = await Purchases.restorePurchases();
    _customerInfo = info;
    return info;
  }

  bool isPremium({String entitlementId = 'premium'}) {
    final entitlements = _customerInfo?.entitlements.active;
    return entitlements?[entitlementId]?.isActive ?? false;
  }
}
