import 'package:flutter/material.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

import 'context_extension.dart';

class InternetConnectivityBuilderExample extends StatelessWidget {
  const InternetConnectivityBuilderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InternetConnectivityBuilder'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            InternetConnectivityBuilder(
              connectivityBuilder: (BuildContext context, bool hasInternetAccess, Widget? child) {
                if (hasInternetAccess) {
                  return const OnlineWidget();
                } else {
                  return const OfflineWidget();
                }
              },
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class OnlineWidget extends StatelessWidget {
  const OnlineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(16)),
      child: Text(
        'Online!',
        style: context.textTheme.headline4?.copyWith(color: Colors.white),
      ),
    );
  }
}

class OfflineWidget extends StatelessWidget {
  const OfflineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(16)),
      child: Text(
        'Offline!',
        style: context.textTheme.headline4?.copyWith(color: Colors.white),
      ),
    );
  }
}
