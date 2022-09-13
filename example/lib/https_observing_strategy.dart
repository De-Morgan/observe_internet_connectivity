import 'package:http/http.dart' as http;
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

class HttpObservingStrategy extends InternetObservingStrategy {
  final String lookUpAddress;

  HttpObservingStrategy({this.lookUpAddress = 'www.google.com'});

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
