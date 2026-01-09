import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef WaterExitCallback = void Function();

class WaterExitHandler {
  WaterExitHandler._();

  static WaterExitCallback? onExit;

  static void exit() {
    onExit?.call();
  }
}

class WaterBackButton extends StatelessWidget {
  const WaterBackButton({super.key});

  void _handleBack(BuildContext context) {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
      return;
    }
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }
    WaterExitHandler.exit();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () => _handleBack(context),
    );
  }
}
