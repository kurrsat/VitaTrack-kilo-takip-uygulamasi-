import 'dart:async';
class SyncScheduler {
  Timer? _timer;

  void start({required Future<void> Function() sync, Duration interval = const Duration(minutes: 15)}) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) {
      sync();
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }
}
