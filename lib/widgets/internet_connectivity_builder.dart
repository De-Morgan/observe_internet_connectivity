import 'package:flutter/material.dart';

import '../internet_connectivity.dart';

typedef ConnectivityBuilder = Widget Function(
    BuildContext context, bool hasInternetAccess, Widget? child);

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

  final Widget? child;
  InternetConnectivity? _internetConnectivity;
  final ConnectivityBuilder connectivityBuilder;
  final bool initialData;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: initialData,
      stream: _internetConnectivity!.observeInternetAccess,
      builder: (context, snapshot) {
        return connectivityBuilder.call(context, snapshot.data!, child);
      },
    );
  }
}
