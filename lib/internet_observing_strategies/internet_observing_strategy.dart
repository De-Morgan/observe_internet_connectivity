part of observe_internet_connectivity;

///The base for all Observing strategies. If you'd like to create a new Strategy, extend from this class.
/// check [SocketObservingStrategy] for strategy that opens a socket to a list of specified addresses
abstract class InternetObservingStrategy {
  /// The initial duration to wait before observing internet access
  Duration? get initialDuration;

  /// The interval between periodic observing.
  Duration get interval;

  /// The duration to listen for connection event
  Duration? get duration => null;

  /// The strategy to use to determine is there is internet access or not
  /// check [SocketObservingStrategy] for a sample
  Future<bool> get hasInternetConnection;

  /// If true, the strategy will stop observing for internet changes as soon as the device is online
  bool get disposeOnFirstConnected => false;

  /// If true, the strategy will stop observing for internet changes as soon as the device is offline
  bool get disposeOnFirstDisconnected => false;
}
