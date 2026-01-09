import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class QuickAddWaterPage extends ConsumerStatefulWidget {
  const QuickAddWaterPage({super.key});

  @override
  ConsumerState<QuickAddWaterPage> createState() => _QuickAddWaterPageState();
}

class _QuickAddWaterPageState extends ConsumerState<QuickAddWaterPage> {
  bool _done = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _quickAdd());
  }

  Future<void> _quickAdd() async {
    if (_done) {
      return;
    }
    _done = true;
    if (mounted) {
      context.go('/water');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: LoadingView(label: strings.quickAddWaterLoading),
      ),
    );
  }
}
