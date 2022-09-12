import 'models/internet_address.dart';

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
