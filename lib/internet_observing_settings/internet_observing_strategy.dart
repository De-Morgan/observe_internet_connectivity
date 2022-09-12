export 'default_observing_strategy.dart';
export 'dispose_after_duration.dart';
export 'dispose_on_first_connected.dart';
export 'dispose_on_first_disconnected.dart';
export 'socket_connection_strategy.dart';

abstract class InternetObservingStrategy {

  Duration? get initialDuration;

  Duration get interval;

  Duration? get duration => null;

  Future<bool> get hasInternetAccess;

  bool get disposeOnFirstConnected => false;

  bool get disposeOnFirstDisconnected => false;
}
