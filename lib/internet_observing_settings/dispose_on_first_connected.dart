import '../constants.dart';
import 'socket_connection_strategy.dart';

class DisposeOnFirstConnectedStrategy extends SocketConnectionStrategy {
  DisposeOnFirstConnectedStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});

  @override
  bool get disposeOnFirstConnected => true;
}
