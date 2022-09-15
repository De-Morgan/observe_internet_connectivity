part of observe_internet_connectivity;

typedef ConnectivityListener = Function(
    BuildContext context, bool hasInternetAccess);

///Use [InternetConnectivityListener] to listen to internet connectivity changes inside a flutter widget
///
///  return InternetConnectivityListener(
///       connectivityListener: (BuildContext context, bool hasInternetAccess) {
///         if (hasInternetAccess) {
///           context.showBanner('You are back Online!', color: Colors.green);
///         } else {
///           context.showBanner('No internet connection', color: Colors.red);
///         }
///       },
///       child: Scaffold(
///         body: Container(),
///       ),
///     );
// ignore: must_be_immutable
class InternetConnectivityListener extends StatefulWidget {
  InternetConnectivityListener({
    Key? key,
    required this.child,
    required this.connectivityListener,
    InternetConnectivity? internetConnectivity,
  }) : super(key: key) {
    _internetConnectivity = internetConnectivity ?? InternetConnectivity();
  }

  /// The child widget of [InternetConnectivityListener]
  final Widget child;
  InternetConnectivity? _internetConnectivity;

  /// The function that is being triggered when there is changes in the internet connection
  /// e.g from Offline to online or vise versa
  ///
  final ConnectivityListener connectivityListener;

  @override
  _InternetConnectivityListenerState createState() =>
      _InternetConnectivityListenerState();
}

class _InternetConnectivityListenerState
    extends State<InternetConnectivityListener> {
  ConnectivityListener? get onConnectivityChanged =>
      widget.connectivityListener;

  InternetConnectivity get internetConnectivity =>
      widget._internetConnectivity!;

  late StreamSubscription<bool> subscription;

  @override
  void initState() {
    super.initState();
    subscription =
        internetConnectivity.observeInternetConnection.listen((event) {
      onConnectivityChanged?.call(context, event);
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
