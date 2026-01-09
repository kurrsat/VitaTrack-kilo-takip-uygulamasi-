import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/features/weight/add_weight_dialog.dart';
import 'package:weightvault/l10n/app_localizations.dart';
class QuickAddWeightPage extends ConsumerStatefulWidget {
  const QuickAddWeightPage({super.key});

  @override
  ConsumerState<QuickAddWeightPage> createState() => _QuickAddWeightPageState();
}

class _QuickAddWeightPageState extends ConsumerState<QuickAddWeightPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (_) => const AddWeightDialog(),
      );
      if (mounted) {
        context.go('/home/dashboard');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: LoadingView(label: strings.quickAddWeightLoading),
      ),
    );
  }
}
