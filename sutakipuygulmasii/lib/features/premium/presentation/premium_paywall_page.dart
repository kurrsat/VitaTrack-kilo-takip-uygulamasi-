import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/core/services/purchase_service.dart';
import 'package:water_reminder/features/premium/presentation/premium_providers.dart';
import 'package:water_reminder/app/exit_handler.dart';

/// Premium paywall page
class PremiumPaywallPage extends ConsumerWidget {
  const PremiumPaywallPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsync = ref.watch(premiumProductsProvider);
    final isPremiumAsync = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: const Text('Premium'),
        actions: [
          // Debug toggle for testing
          if (isPremiumAsync.value == true)
            IconButton(
              icon: const Icon(Icons.star, color: Colors.amber),
              onPressed: () {},
              tooltip: 'Premium Aktif',
            ),
        ],
      ),
      body: isPremiumAsync.when(
        data: (isPremium) {
          if (isPremium) {
            return _buildPremiumActiveView(context);
          }
          return productsAsync.when(
            data: (products) => _buildPaywallView(context, ref, products),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Hata: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }

  Widget _buildPaywallView(
    BuildContext context,
    WidgetRef ref,
    List<PremiumProduct> products,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade400,
                  Colors.purple.shade400,
                ],
              ),
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.star,
                  size: 80,
                  color: Colors.amber,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Premiuma Gec',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tum ozellikleri ac ve su takibini guclendir',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Features
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildFeatureItem(
                  Icons.local_drink,
                  'Sinirsiz Bardak',
                  'Ihtiyacin kadar bardak ekle',
                  Colors.blue,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.calendar_today,
                  'Isi Haritasi',
                  'Aylara gore su takibini gor',
                  Colors.green,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.shield,
                  'Seri Koruma',
                  'Bir gun kacirdiginda serini koru',
                  Colors.orange,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.cloud_off,
                  'Reklamsiz',
                  'Tamamen reklamsiz deneyim',
                  Colors.purple,
                ),
                const SizedBox(height: 16),
                _buildFeatureItem(
                  Icons.support,
                  'Oncelikli Destek',
                  'Premium destekle daha hizli yardim al',
                  Colors.red,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Pricing Plans
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: products.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _buildPlanCard(
                    context,
                    ref,
                    product,
                    isPopular: product.period == PremiumPeriod.yearly,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Restore purchases
          TextButton(
            onPressed: () async {
              final service = ref.read(purchaseServiceProvider);
              await service.restorePurchases();
              ref.invalidate(isPremiumProvider);
            },
            child: const Text('Satin Almalari Geri Yukle'),
          ),

          const SizedBox(height: 32),

          // Disclaimer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'TODO: Gercek odeme entegrasyonu bekleniyor\n'
              'Su an test icin sahte satin alma servisi kullaniliyor',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPremiumActiveView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.star,
                size: 80,
                color: Colors.amber,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Premium Aktif',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tum premium ozelliklere erisim var!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildActiveFeature(Icons.local_drink, 'Sinirsiz Bardak'),
                    _buildActiveFeature(Icons.calendar_today, 'Isi Haritasi'),
                    _buildActiveFeature(Icons.shield, 'Seri Koruma'),
                    _buildActiveFeature(Icons.cloud_off, 'Reklamsiz'),
                    _buildActiveFeature(Icons.support, 'Oncelikli Destek'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    IconData icon,
    String title,
    String description,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    WidgetRef ref,
    PremiumProduct product, {
    bool isPopular = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: isPopular ? Colors.amber : Colors.grey.shade300,
          width: isPopular ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: isPopular ? Colors.amber.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _handlePurchase(context, ref, product),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (isPopular)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'EN IYI TEKLIF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (isPopular) const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            product.description,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      product.price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveFeature(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Future<void> _handlePurchase(
    BuildContext context,
    WidgetRef ref,
    PremiumProduct product,
  ) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    final service = ref.read(purchaseServiceProvider);
    bool success = false;

    switch (product.period) {
      case PremiumPeriod.monthly:
        success = await service.purchaseMonthly();
        break;
      case PremiumPeriod.yearly:
        success = await service.purchaseYearly();
        break;
      case PremiumPeriod.lifetime:
        success = await service.purchaseLifetime();
        break;
    }

    if (context.mounted) {
      Navigator.of(context).pop(); // Close loading

      if (success) {
        // Refresh premium status
        ref.invalidate(isPremiumProvider);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Premiuma Hos Geldin!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Satin alma basarisiz. Tekrar dene.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
