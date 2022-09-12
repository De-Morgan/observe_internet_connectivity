import 'package:observe_internet_connectivity/internet_connectivity.dart';

void isConnectedToInternet() async {
  final hasInternet = await InternetConnectivity().hasInternetConnection;
  if (hasInternet) {
    //You are connected to the internet
  } else {
    //"No internet connection
  }
}
