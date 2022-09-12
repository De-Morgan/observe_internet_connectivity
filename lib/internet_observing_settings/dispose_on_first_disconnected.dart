import '../constants.dart';
import 'socket_observing_strategy.dart';

class DisposeOnFirstDisconnectedStrategy extends SocketObservingStrategy {
  DisposeOnFirstDisconnectedStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});

  @override
  bool get disposeOnFirstDisconnected => true;
}
