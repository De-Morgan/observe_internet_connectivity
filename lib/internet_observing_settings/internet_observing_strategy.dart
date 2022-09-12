export 'default_observing_strategy.dart';
export 'dispose_after_duration.dart';
export 'dispose_on_first_connected.dart';
export 'dispose_on_first_disconnected.dart';
export 'socket_observing_strategy.dart';

///The base for all Observing strategies. If you'd like to create a new Strategy, extend from this class.
/// check [SocketObservingStrategy] for strategy that opens a socket to a list of specified addresses
abstract class InternetObservingStrategy {
  Duration? get initialDuration;

  Duration get interval;

  Duration? get duration => null;

  /// The strategy to use to determine is there is internet access or not
  /// check [SocketObservingStrategy] for a sample
  Future<bool> get hasInternetAccess;

  bool get disposeOnFirstConnected => false;

  bool get disposeOnFirstDisconnected => false;
}
