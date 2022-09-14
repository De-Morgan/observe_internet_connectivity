import '../constants.dart';
import 'socket_observing_strategy.dart';

///This strategy cancel the subscription automatically after the first connected event,
/// i.e once the device has internet connection, the stream subscription will be automatically closed.
///   @override
///   bool get disposeOnFirstConnected => true;
///
class DisposeOnFirstConnectedStrategy extends SocketObservingStrategy {
  DisposeOnFirstConnectedStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});

  @override
  bool get disposeOnFirstConnected => true;
}
