part of observe_internet_connectivity;

///The [InternetConnectivity] class is responsible for observing the internet connectivity using the [InternetObservingStrategy] and a [StreamController] to emit internet connection changes.
/// If no strategy is supplied when creating [InternetConnectivity], the [DefaultObServingStrategy] will be used.
///
/// InternetConnectivity({InternetObservingStrategy? internetObservingStrategy}) {
///     _internetObservingStrategy =
///         internetObservingStrategy ?? DefaultObServingStrategy();
///     _internetAccessCheckController = StreamController<bool>.broadcast(
///         onCancel: _onCancelStream, onListen: _emitInitialInternetAccess);
///   }
class InternetConnectivity {
  late StreamController<bool> _internetAccessCheckController;
  late final InternetObservingStrategy _internetObservingStrategy;
  bool? _lastInternetAccessCheck;
  Timer? _intervalTimer, _disposeTimer;
  bool _streamIsClosed = false;

  InternetConnectivity({InternetObservingStrategy? internetObservingStrategy}) {
    _internetObservingStrategy =
        internetObservingStrategy ?? DefaultObServingStrategy();
    _internetAccessCheckController = StreamController<bool>.broadcast(
        onCancel: _onCancelStream, onListen: _emitInitialInternetAccess);
  }

  /// The Check to know if the device has internet connection
  ///   final hasInternet = await InternetConnectivity().hasInternetConnection;
  //   if (hasInternet) {
  //     //You are connected to the internet
  //   } else {
  //     //"No internet connection
  //   }
  Future<bool> get hasInternetConnection =>
      _internetObservingStrategy.hasInternetConnection;

  /// Steam to emit internet connection changes i.e from Offline to online or vise versa
  /// Changes are only pushed when the stream has an active listener
  ///
  Stream<bool> get observeInternetConnection =>
      _internetAccessCheckController.stream;

  Future<void> _emitInternetAccess() async {
    if (_streamIsClosed) return;
    _intervalTimer?.cancel();
    final isConnected = await hasInternetConnection;
    _addToStream(isConnected);
    _intervalTimer =
        Timer(_internetObservingStrategy.interval, _emitInternetAccess);
  }

  Future<void> _emitInitialInternetAccess() async {
    _disposeAfterDuration();
    final isConnected = await Future.delayed(
        _internetObservingStrategy.initialDuration ?? kDefaultInitialDuration,
        () => hasInternetConnection);
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
    _disposeTimer?.cancel();
    _lastInternetAccessCheck = null;
    _streamIsClosed = true;
  }

  void _disposeAfterDuration() {
    if (_internetObservingStrategy.duration != null) {
      if (!_hasListener) return;
      _disposeTimer = Timer(_internetObservingStrategy.duration!, () {
        _internetAccessCheckController.close();
      });
    }
  }

  bool get _hasListener => _internetAccessCheckController.hasListener;
}
