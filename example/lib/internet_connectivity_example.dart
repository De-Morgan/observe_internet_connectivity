import 'package:flutter/material.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

class ShowInternetConnectionToast extends StatelessWidget {
  const ShowInternetConnectionToast({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InternetConnectivityListener(
      connectivityListener: (BuildContext context, bool hasInternetAccess) {
        if (!hasInternetAccess) {
         // showToast('No internet connection');
        }
      },
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
