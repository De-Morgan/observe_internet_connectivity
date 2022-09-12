import 'dart:async';
import 'dart:io';

import '../models/internet_address.dart';
import 'internet_observing_strategy.dart';

////The base for all Observing strategies for strategy that opens a socket to a list of specified addresses.
abstract class SocketObservingStrategy extends InternetObservingStrategy {
  /// The initial duration to wait before observing internet access
  ///
  /// Defaults to [kDefaultInitialDuration] (0 seconds)
  @override
  final Duration? initialDuration;

  /// The interval between periodic observing.
  ///
  /// Defaults to [kDefaultInterval] (5 seconds).
  @override
  final Duration interval;

  /// The timeout period before a check request is dropped and an address is
  /// considered unreachable.
  ///
  /// If not null, it is set to the [timeOut] for each of the [internetAddresses].
  ///  if (timeOut != null) {
  ///       internetAddresses = internetAddresses
  ///           .map((e) => e.copyWith(timeOut: timeOut))
  ///           .toList(growable: false);
  ///     }
  final Duration? timeOut;

  /// A list of internet addresses (with port and timeout) to ping.
  ///
  /// These should be globally available destinations.
  ///
  /// Default is [kDefaultInternetAddresses].
  List<InternetAddress> internetAddresses;

  SocketObservingStrategy(
      {this.initialDuration,
      required this.interval,
      this.timeOut,
      required this.internetAddresses}) {
    if (timeOut != null) {
      internetAddresses = internetAddresses
          .map((e) => e.copyWith(timeOut: timeOut))
          .toList(growable: false);
    }
  }

  /// The observing strategy is to ping each of the [internetAddresses] supplied,
  /// Using [stream.any] to check for the first address to connect.
  /// Once an address connects, it is assumed that there is internet access and the process stops
  ///
  @override
  Future<bool> get hasInternetConnection async {
    final futures = internetAddresses
        .map((internetAddress) => _hasInternet(internetAddress));
    final stream = Stream.fromFutures(futures);
    return stream.any((element) => element);
  }

  Future<bool> _hasInternet(InternetAddress internetAddress) async {
    Socket? sock;
    try {
      sock = await Socket.connect(
        internetAddress.host,
        internetAddress.port,
        timeout: internetAddress.timeOut,
      )
        ..destroy();
      return true;
    } catch (_) {
      sock?.destroy();
      return false;
    }
  }
}
