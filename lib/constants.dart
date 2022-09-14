import 'models/internet_address.dart';

/// The default [internetAddresses] used if non is supplied to [SocketObservingStrategy]
const kDefaultInternetAddresses = [
  InternetAddress(
      host: _googleHost, port: _defaultPort, timeOut: _defaultTimeOut),
  InternetAddress(
      host: _cloudFlareHost, port: _defaultPort, timeOut: _defaultTimeOut),
];

/// The default [interval] used if non is supplied to [SocketObservingStrategy]
const kDefaultInterval = Duration(seconds: 5);

/// The default [initialDuration] used if non is supplied to [SocketObservingStrategy]
const kDefaultInitialDuration = Duration(seconds: 0);

const _googleHost = '8.8.8.8';
const _cloudFlareHost = '1.1.1.1';
const _defaultPort = 53;

/// The default [timeOut] used if non is supplied to [SocketObservingStrategy]
const _defaultTimeOut = Duration(seconds: 3);
