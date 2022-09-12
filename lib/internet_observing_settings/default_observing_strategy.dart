import '../constants.dart';
import 'socket_connection_strategy.dart';

class DefaultObServingStrategy extends SocketConnectionStrategy {
  DefaultObServingStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});
}
