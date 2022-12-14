part of observe_internet_connectivity;

///This is the strategy used if you don't supply any strategy to the [InternetConnectivity] class,
/// you will have to cancel the subscription manually.
///
class DefaultObServingStrategy extends SocketObservingStrategy {
  DefaultObServingStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});
}
