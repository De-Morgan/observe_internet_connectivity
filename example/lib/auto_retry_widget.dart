import 'package:example/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

import 'provider_observing_strategy.dart';

class AutoRetryWidget extends StatelessWidget {
  const AutoRetryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto retry example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            Widget widget;
            final dataState = ref.watch(dataProvider);
            switch (dataState) {
              case DataState.loading:
                widget = const Center(child: CircularProgressIndicator());
                break;
              case DataState.error:
                widget = const _RetryWidget();
                break;
              case DataState.loaded:
                widget = const _LoadedWidget();
                break;
            }
            return widget;
          },
        ),
      ),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget();

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
      children: [
        ...pizzas.map((pizza) => Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: context.themeData.cardColor,
                  image: DecorationImage(
                      image: NetworkImage(pizza), fit: BoxFit.cover)),
            ))
      ],
    );
  }
}

class _RetryWidget extends ConsumerWidget {
  const _RetryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InternetConnectivityListener(
      internetConnectivity: ref.read(disposeOnFirstConnectedProvider),
      connectivityListener: (BuildContext context, bool hasInternetAccess) {
        if (hasInternetAccess) {
          ref.read(dataProvider.notifier).fetchData();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Spacer(flex: 3,),
          Icon(Icons.refresh_outlined, size: 80,),
          Spacer(),
          Text('No internet connection, please connect to the internet', textAlign: TextAlign.center,),
          Spacer(flex: 10,),
        ],
      ),
    );
  }
}

enum DataState { loading, error, loaded }

class FakeDataNotifier extends StateNotifier<DataState> {
  FakeDataNotifier() : super(DataState.loading) {
    fetchDataError();
  }

  fetchDataError() async {
    state = DataState.loading;
    await Future.delayed(const Duration(seconds: 1));
    state = DataState.error;
  }

  fetchData() async {
    state = DataState.loading;
    await Future.delayed(const Duration(seconds: 3));
    state = DataState.loaded;
  }
}

final dataProvider = StateNotifierProvider<FakeDataNotifier, DataState>(
    (ref) => FakeDataNotifier());

List<String> pizzas = [
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1.jpg',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1.jpg',
  'https://www.kitchentreaty.com/wp-content/uploads/2017/02/how-to-make-heart-shaped-pizzas-featured-420x500.jpg',
  'https://www.kitchentreaty.com/wp-content/uploads/2017/02/how-to-make-heart-shaped-pizzas-featured-420x500.jpg',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1.jpg',
  'https://www.indianhealthyrecipes.com/wp-content/uploads/2015/10/pizza-recipe-1.jpg',
];
