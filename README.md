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

A flutter package that helps to observes internet connection via a customizable observing strategy

## Available Features

1. **Check to know if the device has internet connection**

```dart
  final hasInternet = await InternetConnectivity().hasInternetConnection;
  if (hasInternet) {
    //You are connected to the internet
  } else {
    //"No internet connection
  }
  ```

2. **Listen to internet connectivity changes via stream**

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
Note:bell:: This example uses the `DefaultObServingStrategy` therefore you need to remember to close the stream manually, Other available strategies have mechanism in which the streams are closed automatically.

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
  This returns the `OnlineWidget` when the user has internet connection and returns the `OfflineWidget` widget when the user is disconnected


## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
