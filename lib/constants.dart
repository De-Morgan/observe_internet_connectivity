import 'models/internet_address.dart';

/// Predefined reliable addresses. This is opinionated but should be enough
/// The default [internetAddresses] used if non is supplied to [SocketObservingStrategy]
/// | Address        | Provider   | Info                                            |
/// |:---------------|:-----------|:------------------------------------------------|
/// | 1.1.1.1        | CloudFlare | https://1.1.1.1                                 |
/// | 1.0.0.1        | CloudFlare | https://1.1.1.1                                 |
/// | 8.8.8.8        | Google     | https://developers.google.com/speed/public-dns/ |
/// | 8.8.4.4        | Google     | https://developers.google.com/speed/public-dns/ |
/// | 208.67.222.222 | OpenDNS    | https://use.opendns.com/                        |
/// | 208.67.220.220 | OpenDNS    | https://use.opendns.com/                        |
///
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
