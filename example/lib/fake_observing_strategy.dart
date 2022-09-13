
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

class FakeObservingStrategy extends InternetObservingStrategy {
  @override
  Future<bool> get hasInternetConnection async => true;

  @override
  Duration? get initialDuration => const Duration(seconds: 0);

  @override
  Duration get interval => const Duration(seconds: 5);
}