import '../constants.dart';
import 'socket_connection_strategy.dart';

class DisposeOnFirstDisconnectedStrategy extends SocketConnectionStrategy {
  DisposeOnFirstDisconnectedStrategy(
      {super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});

  @override
  bool get disposeOnFirstDisconnected => true;
}
