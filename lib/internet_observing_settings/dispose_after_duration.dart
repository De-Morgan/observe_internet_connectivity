import '../constants.dart';
import 'socket_observing_strategy.dart';

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
