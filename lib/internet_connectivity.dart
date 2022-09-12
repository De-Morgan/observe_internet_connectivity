import 'dart:async';

import 'constants.dart';
import 'internet_observing_settings/internet_observing_strategy.dart';

class InternetConnectivity {
  late StreamController<bool> _internetAccessCheckController;
  late final InternetObservingStrategy _internetObservingStrategy;
  bool? _lastInternetAccessCheck;
  Timer? _intervalTimer, disposeTimer;
  bool _streamIsClosed = false;

  InternetConnectivity({InternetObservingStrategy? internetObservingStrategy}) {
    _internetObservingStrategy =
        internetObservingStrategy ?? DefaultObServingStrategy();
    _internetAccessCheckController = StreamController<bool>.broadcast(
        onCancel: _onCancelStream, onListen: _emitInitialInternetAccess);
  }

  Future<bool> get hasInternetAccess =>
      _internetObservingStrategy.hasInternetAccess;

  Stream<bool> get observeInternetAccess =>
      _internetAccessCheckController.stream;

  Future<void> _emitInternetAccess() async {
    if (_streamIsClosed) return;
    _intervalTimer?.cancel();
    final isConnected = await hasInternetAccess;
    _addToStream(isConnected);
    _intervalTimer =
        Timer(_internetObservingStrategy.interval, _emitInternetAccess);
  }

  Future<void> _emitInitialInternetAccess() async {
    _disposeAfterDuration();
    final isConnected = await Future.delayed(
        _internetObservingStrategy.initialDuration ?? kDefaultInitialDuration,
        () => hasInternetAccess);
    _addToStream(isConnected);
    _emitInternetAccess();
  }

  void _addToStream(bool value) {
    if (!_hasListener) return;
    if (value == _lastInternetAccessCheck) return;
    _lastInternetAccessCheck = value;
    _internetAccessCheckController.add(value);
    if (value && _internetObservingStrategy.disposeOnFirstConnected) {
      _internetAccessCheckController.close();
    }
    if (!value && _internetObservingStrategy.disposeOnFirstDisconnected) {
      _internetAccessCheckController.close();
    }
  }

  void _onCancelStream() {
    _intervalTimer?.cancel();
    disposeTimer?.cancel();
    _lastInternetAccessCheck = null;
    _streamIsClosed = true;
  }

  void _disposeAfterDuration() {
    if (_internetObservingStrategy.duration != null) {
      if (!_hasListener) return;
      disposeTimer = Timer(_internetObservingStrategy.duration!, () {
        _internetAccessCheckController.close();
      });
    }
  }

  bool get _hasListener => _internetAccessCheckController.hasListener;
}
