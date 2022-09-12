import 'dart:async';
import 'dart:io';

import '../models/internet_address.dart';
import 'internet_observing_strategy.dart';

abstract class SocketConnectionStrategy extends InternetObservingStrategy {
  @override
  final Duration? initialDuration;

  @override
  final Duration interval;

  final Duration? timeOut;

  List<InternetAddress> internetAddresses;

  SocketConnectionStrategy(
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

  @override
  Future<bool> get hasInternetAccess async {
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
