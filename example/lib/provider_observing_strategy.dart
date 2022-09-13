


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

final observingStrategyProvider = Provider<InternetObservingStrategy>((ref) =>
    DefaultObServingStrategy(
        timeOut: const Duration(seconds: 5),
        initialDuration: const Duration(minutes: 2)));

final internetConnectivityProvider = Provider<InternetConnectivity>((ref) {
  return InternetConnectivity(
      internetObservingStrategy: ref.watch(observingStrategyProvider));
});