import '../constants.dart';
import 'socket_connection_strategy.dart';

class DisposeAfterDurationStrategy extends SocketConnectionStrategy {
  @override
  final Duration duration;

  DisposeAfterDurationStrategy(
      {required this.duration,
      super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});
}
