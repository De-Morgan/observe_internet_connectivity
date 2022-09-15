part of observe_internet_connectivity;

///This strategy set the duration to listen for the internet connection events,
/// the subscription will be closed once the duration elapses
///
class DisposeAfterDurationStrategy extends SocketObservingStrategy {
  @override
  final Duration duration;

  DisposeAfterDurationStrategy(
      {required this.duration,
      super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});
}
