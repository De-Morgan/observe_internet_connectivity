import '../constants.dart';
import 'socket_observing_strategy.dart';

class DisposeOnFirstConnectedStrategy extends SocketObservingStrategy {
  DisposeOnFirstConnectedStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});

  @override
  bool get disposeOnFirstConnected => true;
}
