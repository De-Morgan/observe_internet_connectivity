import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

final observingStrategyProvider = Provider<InternetObservingStrategy>((ref) =>
    DisposeOnFirstConnectedStrategy(timeOut: const Duration(seconds: 2)));

/// Provide single instance across the entire app
final disposeOnFirstConnectedProvider = Provider<InternetConnectivity>((ref) {
  return InternetConnectivity(
      internetObservingStrategy: ref.watch(observingStrategyProvider));
});
