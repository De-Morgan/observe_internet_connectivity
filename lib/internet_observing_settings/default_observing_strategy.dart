import '../constants.dart';
import 'socket_observing_strategy.dart';

class DefaultObServingStrategy extends SocketObservingStrategy {
  DefaultObServingStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});
}
