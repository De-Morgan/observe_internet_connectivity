<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->
A flutter package that helps to observe internet connection via a customizable observing strategy

## Problem Statement

> I found that just using the connectivity package was not enough to tell if the internet was available or not. It only checks if there is WIFI or if mobile data is turned on, it does not check for an actual internet connection...

Read more about the issue [here](https://stackoverflow.com/questions/49648022/check-whether-there-is-an-internet-connection-available-on-flutter-app/73724798?answertab=modifieddesc#tab-top)

## Available Features

1. **Check to know if a device has an internet connection**

```dart
  final hasInternet = await InternetConnectivity().hasInternetConnection;
  if (hasInternet) {
    //You are connected to the internet
  } else {
    //"No internet connection
  }
  ```

2. **Listen to internet connection changes via stream**

```dart
  final subscription =
      InternetConnectivity().observeInternetConnection.listen((bool hasInternetAccess) {
        if(!hasInternetAccess){
          showToast('No Internet Connection');
        }
      });

   await Future.delayed(const Duration(seconds: 10 ));
   subscription.cancel();
   ```
Note:bell:: This example uses the `DefaultObServingStrategy` therefore you need to remember to cancel the subscription manually, Other available strategies have a mechanism in which the subscription is automatically cancelled.

3. **Use `InternetConnectivityListener` to listen to internet connectivity changes inside a flutter widget**

```dart
    return InternetConnectivityListener(
      connectivityListener: (BuildContext context, bool hasInternetAccess) {
        if (hasInternetAccess) {
          context.showBanner('You are back Online!', color: Colors.green);
        } else {
          context.showBanner('No internet connection', color: Colors.red);
        }
      },
      child: Scaffold(
        body: Container(),
      ),
    );
  ```  
  
This is mostly useful if you want to get notified of internet connection changes in the widget class, either to retry a failed request or to give the user some feedback about their network state.

 ![](https://raw.githubusercontent.com/De-Morgan/observe_internet_connectivity/master/demo/Listener.gif)


4. **Use `InternetConnectivityBuilder` to build internet connection aware widgets**

```dart
    return InternetConnectivityBuilder(
      connectivityBuilder: (BuildContext context, bool hasInternetAccess, Widget? child) { 
        if(hasInternetAccess) {
          return OnlineWidget();
        } else {
          return OfflineWidget();
        }
      },
      child: ChildWidget(),
    );
   ```
  This returns the `OnlineWidget` when the user has an internet connection and returns the `OfflineWidget` widget when the user is disconnected

 ![](https://raw.githubusercontent.com/De-Morgan/observe_internet_connectivity/master/demo/Builder.gif)
 

## Deep Dive

The `InternetConnectivity` class is responsible for observing the internet connectivity using the `InternetObservingStrategy` and a `StreamController` to emit internet connection changes. If no strategy is supplied when creating `InternetConnectivity`, the `DefaultObServingStrategy` will be used.

```dart
  InternetConnectivity({InternetObservingStrategy? internetObservingStrategy}) {
    _internetObservingStrategy =
        internetObservingStrategy ?? DefaultObServingStrategy();
    _internetAccessCheckController = StreamController<bool>.broadcast(
        onCancel: _onCancelStream, onListen: _emitInitialInternetAccess);
  }
  ```
  
The package checks for active internet connection by opening a socket to a list of specified addresses, each with an individual port and timeout using  `SocketObservingStrategy`. If you'd like to implement a different type of observing strategy, you can create a new strategy by extending `InternetObservingStrategy`. All observing strategies are a sub-class of `InternetObservingStrategy`

  ### `SocketObservingStrategy`

```dart
abstract class SocketObservingStrategy extends InternetObservingStrategy {
  /// The initial duration to wait before observing internet access
  ///
  /// Defaults to [kDefaultInitialDuration] (0 seconds)
  @override
  final Duration? initialDuration;

  /// The interval between periodic observing.
  ///
  /// Defaults to [kDefaultInterval] (5 seconds).
  @override
  final Duration interval;

  /// The timeout period before a check request is dropped and an address is
  /// considered unreachable.
  ///
  /// If not null, it is set to the [timeOut] for each of the [internetAddresses].
  ///  if (timeOut != null) {
  ///       internetAddresses = internetAddresses
  ///           .map((e) => e.copyWith(timeOut: timeOut))
  ///           .toList(growable: false);
  ///     }
  final Duration? timeOut;

  /// A list of internet addresses (with port and timeout) to ping.
  ///
  /// These should be globally available destinations.
  ///
  /// Default is [kDefaultInternetAddresses].
  List<InternetAddress> internetAddresses;

  SocketObservingStrategy(
      {this.initialDuration,
      required this.interval,
      this.timeOut,
      required this.internetAddresses}) {
    if (timeOut != null) {
      internetAddresses = internetAddresses
          .map((e) => e.copyWith(timeOut: timeOut))
          .toList(growable: false);
    }
  }

  /// The observing strategy is to ping each of the [internetAddresses] supplied,
  /// Using [stream.any] to check for the first address to connect.
  /// Once an address connects, it is assumed that there is internet access and the process stops
  ///
  @override
  Future<bool> get hasInternetConnection async {
    final futures = internetAddresses
        .map((internetAddress) => _hasInternet(internetAddress));
    final stream = Stream.fromFutures(futures);
    return stream.any((element) => element);
  }

  Future<bool> _hasInternet(InternetAddress internetAddress) async {
    Socket? sock;
    try {
      sock = await Socket.connect(
        internetAddress.host,
        internetAddress.port,
        timeout: internetAddress.timeOut,
      )
        ..destroy();
      return true;
    } catch (_) {
      sock?.destroy();
      return false;
    }
  }
}
  ```
The library comes with 4 different strategies that extend `SocketObservingStrategy` for a different use cases, namely;

1. `DefaultObServingStrategy`:
This is the strategy used if you don't supply any strategy to the `InternetConnectivity` class, you will have to cancel the subscription manually.

2. `DisposeOnFirstConnectedStrategy`:
This strategy cancels the subscription automatically after the first connected event, i.e once the device has an internet connection, the stream subscription will be automatically closed.

3. `DisposeOnFirstDisconnectedStrategy`:
This strategy cancels the subscription automatically after the first disconnected event, i.e once the device is offline, the stream subscription will be automatically closed.

4. `DisposeAfterDurationStrategy`:
This strategy set the duration to listen for the internet connection events, the subscription will be closed once the duration elapses

```dart
class DisposeAfterDurationStrategy extends SocketObservingStrategy {
  @override
  final Duration duration;
  
  DisposeAfterDurationStrategy(
      {required this.duration,
      super.timeOut,
      super.interval = kDefaultInterval,
      super.initialDuration = kDefaultInitialDuration,
      super.internetAddresses = kDefaultInternetAddresses});
}
```
each of the strategies is initiated with default values for convenience, you can override any of the default values. e.g creating a 
`DefaultObServingStrategy` with a `timeOut` of 5 sec and `initialDuration` of 2 mins.

```dart
    DefaultObServingStrategy(
      timeOut: const Duration(seconds: 5),
      initialDuration: const Duration(minutes: 2)
    )
   ```
   
### The Default values
 
 ```dart
 
const kDefaultInternetAddresses = [
  InternetAddress(
      host: _googleHost, port: _defaultPort, timeOut: _defaultTimeOut),
  InternetAddress(
      host: _cloudFlareHost, port: _defaultPort, timeOut: _defaultTimeOut),
];

const kDefaultInterval = Duration(seconds: 5);
const kDefaultInitialDuration = Duration(seconds: 0);
const _googleHost = '8.8.8.8';
const _cloudFlareHost = '1.1.1.1';
const _defaultPort = 53;
const _defaultTimeOut = Duration(seconds: 3);
```

## Implementing your own `InternetObservingStrategy`

For example, you can implement a fake observing strategy for testing as follows;

```dart
class FakeObservingStrategy extends InternetObservingStrategy{
  @override
  Future<bool> get hasInternetConnection async=> true;

  @override
  Duration? get initialDuration => const Duration(seconds: 0);

  @override
  Duration get interval => const Duration(seconds: 5);
}
```

You can also implement an `HttpsObservingStrategy` as follows;

```dart
class HttpsObservingStrategy extends InternetObservingStrategy {
  final String lookUpAddress;

  HttpsObservingStrategy({this.lookUpAddress = 'www.google.com'});

  @override
  Duration? get initialDuration => const Duration(seconds: 0);

  @override
  Duration get interval => const Duration(seconds: 10);

  @override
  Future<bool> get hasInternetConnection async {
    try {
      var url = Uri.https(lookUpAddress, '',);
     await http.get(url);
     return true;
    } catch (_) {
      return false;
    }
  }
}
```

## Auto retry example

This example showcase how you can use the `InternetConnectivityListener` and the `DisposeOnFirstConnectedStrategy` to automaticaly retry a failed network request once the device is back online.

```dart
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
```

Please check [auto_retry_widget.dart](https://github.com/De-Morgan/observe_internet_connectivity/blob/master/example/lib/auto_retry_widget.dart) for the complete code.

![](https://raw.githubusercontent.com/De-Morgan/observe_internet_connectivity/master/demo/AutoRetry.gif)


## Additional information

Note:bell:: The `InternetConnectivity` is not a singleton, for the ease of testing. If you would like to maintain a single instance throughout the app lifecycle, you can:

1. provide a global instance (not recommended)

```dart
final globalInstance = InternetConnectivity(
  internetObservingStrategy:   DefaultObServingStrategy(
      timeOut: const Duration(seconds: 5),
      initialDuration: const Duration(minutes: 2)
  )
);
```
2. Register it with any dependency injection framework e.g GetIt

```dart
  GetIt.instance.registerSingleton<InternetConnectivity>(
      InternetConnectivity(
          internetObservingStrategy:   DefaultObServingStrategy(
              timeOut: const Duration(seconds: 5),
              initialDuration: const Duration(minutes: 2)
          )
      )
  );
  ```
 3.  Use Riverpod Provider (recommended)

```dart
final observingStrategyProvider = Provider<InternetObservingStrategy>((ref)=> 
    DefaultObServingStrategy(
    timeOut: const Duration(seconds: 5),
    initialDuration: const Duration(minutes: 2)
));

final internetConnectivityProvider = Provider<InternetConnectivity>((ref) {
  return InternetConnectivity(internetObservingStrategy: ref.watch(observingStrategyProvider));
});
```


 ***Check more examples in the [example folder](https://github.com/De-Morgan/observe_internet_connectivity/blob/master/example/)***.
 **If you like the project, don't forget to star ⭐️**

## License
This package is licensed under the MIT license. See [LICENSE](https://github.com/De-Morgan/observe_internet_connectivity/blob/master/LICENSE) for details.
