import 'package:flutter/material.dart';

import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.privacyPolicyTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(strings.privacyPolicyBody),
      ),
    );
  }
}
