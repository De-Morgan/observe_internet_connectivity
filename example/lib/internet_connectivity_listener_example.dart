import 'package:flutter/material.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

import 'context_extension.dart';

class ShowInternetConnectionBanner extends StatelessWidget {
  const ShowInternetConnectionBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetConnectivityListener(
      connectivityListener: (BuildContext context, bool hasInternetAccess) {
        if (hasInternetAccess) {
          context.showBanner('You are back Online!', color: Colors.green);
        } else {
          context.showBanner('No internet connection', color: Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('InternetConnectivityListener'),
        ),
        body: Container(),
      ),
    );
  }
}
