import 'package:flutter/material.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

class ShowInternetConnection extends StatelessWidget {
  const ShowInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetConnectivityBuilder(
      connectivityBuilder:
          (BuildContext context, bool hasInternetAccess, Widget? child) {
        if (hasInternetAccess) {
          // return OnlineWidget();
        } else {
          //  return OfflineWidget();
        }
        return Container();
      },
      // child: ChildWidget(),
    );
  }
}
