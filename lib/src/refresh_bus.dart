import 'dart:async';
import 'refresh_event.dart';

class RefreshBus {
  RefreshBus._internal();
  static final RefreshBus _instance = RefreshBus._internal();
  factory RefreshBus() => _instance;

  final StreamController<RefreshEvent> _controller =
  StreamController<RefreshEvent>.broadcast();

  /// Listen to refresh events
  Stream<RefreshEvent> get stream => _controller.stream;

  /// Trigger refresh
  void fire({String? tag}) {
    _controller.add(RefreshEvent(tag: tag));
  }

  /// Dispose (optional)
  void dispose() {
    _controller.close();
  }
}
