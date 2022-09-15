
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

main() async{
  final subscription =
      InternetConnectivity().observeInternetConnection.listen((bool hasInternetAccess) {
        if(!hasInternetAccess){
          //showToast('No Internet Connection');
        }
      });

   await Future.delayed(const Duration(seconds: 10 ));
   subscription.cancel();
}
