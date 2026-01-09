import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:quick_actions/quick_actions.dart';
enum QuickActionType {
  addWater,
}

class QuickActionsService {
  QuickActionsService({QuickActions? quickActions})
      : _quickActions = quickActions ?? const QuickActions();

  final QuickActions _quickActions;
  final StreamController<QuickActionType> _controller =
      StreamController<QuickActionType>.broadcast();

  Stream<QuickActionType> get actions => _controller.stream;

  Future<void> init() async {
    if (kIsWeb ||
        (defaultTargetPlatform != TargetPlatform.android &&
            defaultTargetPlatform != TargetPlatform.iOS)) {
      return;
    }
    await _quickActions.initialize((type) {
      final action = _parseType(type);
      if (action != null && !_controller.isClosed) {
        _controller.add(action);
      }
    });
    await _quickActions.setShortcutItems(
      const [
        ShortcutItem(type: 'add_water', localizedTitle: 'Add Water'),
      ],
    );
  }

  void dispose() {
    _controller.close();
  }

  QuickActionType? _parseType(String? type) {
    switch (type) {
      case 'add_water':
        return QuickActionType.addWater;
    }
    return null;
  }
}
