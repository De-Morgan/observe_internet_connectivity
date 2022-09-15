part of observe_internet_connectivity;

/// This strategy cancel the subscription automatically after the first disconnected event,
/// i.e once the device is offline, the stream subscription will be automatically closed.
/// @override
///   bool get disposeOnFirstDisconnected => true;

class DisposeOnFirstDisconnectedStrategy extends SocketObservingStrategy {
  DisposeOnFirstDisconnectedStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});

  @override
  bool get disposeOnFirstDisconnected => true;
}
