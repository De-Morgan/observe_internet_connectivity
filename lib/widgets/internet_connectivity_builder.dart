part of observe_internet_connectivity;


typedef ConnectivityBuilder = Widget Function(
    BuildContext context, bool hasInternetAccess, Widget? child);

/// Use [InternetConnectivityBuilder] to build internet connection aware widgets.
/// [InternetConnectivityBuilder] use [StreamBuilder] under the hood
///  return InternetConnectivityBuilder(
///       connectivityBuilder: (BuildContext context, bool hasInternetAccess, Widget? child) {
///         if(hasInternetAccess) {
///           return OnlineWidget();
///         } else {
///           return OfflineWidget();
///         }
///       },
///       child: ChildWidget(),
///     );

// ignore: must_be_immutable
class InternetConnectivityBuilder extends StatelessWidget {
  InternetConnectivityBuilder({
    Key? key,
    this.child,
    required this.connectivityBuilder,
    InternetConnectivity? internetConnectivity,
    this.initialData = false,
  }) : super(key: key) {
    _internetConnectivity = internetConnectivity ?? InternetConnectivity();
  }

  /// The child widget to pass to the [InternetConnectivityBuilder].
  ///
  /// If a [ConnectivityBuilder] callback's return value contains a subtree that does not
  /// depend on the connectivity, it's more efficient to build that subtree once
  /// instead of rebuilding it on every connection changes.
  ///
  /// If the pre-built subtree is passed as the [child] parameter, the
  /// [InternetConnectivityBuilder] will pass it back to the [connectivityBuilder] function so that it
  /// can be incorporated into the build.
  ///
  /// Using this pre-built child is entirely optional, but can improve
  /// performance significantly in some cases and is therefore a good practice.
  ///
  final Widget? child;
  InternetConnectivity? _internetConnectivity;

  /// Called every time there is a connection changes.
  /// e.g from offline to online or vice versa
  ///
  final ConnectivityBuilder connectivityBuilder;

  ///The initial data for [StreamBuilder]
  final bool initialData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: initialData,
      stream: _internetConnectivity!.observeInternetConnection,
      builder: (context, snapshot) {
        return connectivityBuilder.call(context, snapshot.data!, child);
      },
    );
  }
}
