import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class PaywallPlan {
  const PaywallPlan({required this.title, required this.description, required this.price});

  final String title;
  final String description;
  final String price;
}

class PremiumPaywallPage extends ConsumerStatefulWidget {
  const PremiumPaywallPage({super.key, this.previewPlans});

  final List<PaywallPlan>? previewPlans;

  @override
  ConsumerState<PremiumPaywallPage> createState() => _PremiumPaywallPageState();
}

class _PremiumPaywallPageState extends ConsumerState<PremiumPaywallPage> {
  late Future<Offerings> _offerings;

  @override
  void initState() {
    super.initState();
    if (widget.previewPlans == null) {
      final premium = ref.read(premiumServiceProvider);
      _offerings = premium.isConfigured
          ? premium.getOfferings()
          : Future<Offerings>.error('not_configured');
      ref.read(crashlyticsProvider).log('paywall_view');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final paywallVariant = ref.watch(featureFlagServiceProvider).paywallVariant.toUpperCase();
    final showBenefitsFirst = paywallVariant != 'B';
    if (widget.previewPlans != null) {
      return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: Text(strings.goPremiumTitle),
        ),
        body: _buildPreview(widget.previewPlans!),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.goPremiumTitle),
      ),
      body: FutureBuilder<Offerings>(
        future: _offerings,
        builder: (context, snapshot) {
          if (widget.previewPlans != null) {
            return _buildPreview(widget.previewPlans!);
          }
          if (snapshot.hasError) {
            return EmptyState(
              title: strings.noOfferingsTitle,
              message: strings.noOfferingsMessage,
              actionLabel: strings.cancel,
              onAction: () => Navigator.of(context).pop(),
            );
          }
          if (!snapshot.hasData) {
            return LoadingView(label: strings.loadingPaywall);
          }
          final offering = snapshot.data!.current;
          if (offering == null) {
            return EmptyState(
              title: strings.noOfferingsTitle,
              message: strings.noOfferingsMessage,
            );
          }
          final packages = showBenefitsFirst
              ? offering.availablePackages
              : offering.availablePackages.reversed.toList();
          final benefitCard = AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.premiumBenefitsTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(strings.premiumBenefitsMessage),
              ],
            ),
          );
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (showBenefitsFirst) benefitCard,
              if (showBenefitsFirst) const SizedBox(height: 16),
              ...packages.map(
                (package) => AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.storeProduct.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(package.storeProduct.description),
                      const SizedBox(height: 8),
                      PrimaryButton(
                        label: strings.subscribeLabel(package.storeProduct.priceString),
                        onPressed: () async {
                          await ref.read(premiumServiceProvider).purchasePackage(package);
                          await ref.read(crashlyticsProvider).log('paywall_purchase');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(strings.purchaseSuccessful)),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if (!showBenefitsFirst) ...[
                const SizedBox(height: 16),
                benefitCard,
              ],
              const SizedBox(height: 16),
              SecondaryButton(
                label: strings.restorePurchases,
                onPressed: () => ref.read(premiumServiceProvider).restorePurchases(),
              ),
              const SizedBox(height: 8),
              SecondaryButton(
                label: strings.manageSubscription,
                onPressed: () async {
                  final info = await Purchases.getCustomerInfo();
                  final url = info.managementURL;
                  if (url == null) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(strings.manageSubscriptionMessage)),
                      );
                    }
                    return;
                  }
                  final uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(strings.unableToOpenSubscriptions)),
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPreview(List<PaywallPlan> plans) {
    final strings = AppLocalizations.of(context)!;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.premiumBenefitsTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(strings.premiumBenefitsMessage),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...plans.map(
          (plan) => AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  plan.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(plan.description),
                const SizedBox(height: 8),
                PrimaryButton(label: strings.subscribeLabel(plan.price), onPressed: null),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
