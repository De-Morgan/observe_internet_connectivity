
class InternetAddress {
  final String host;
  final int port;
  final Duration timeOut;
  const InternetAddress(
      {required this.host, required this.port, required this.timeOut});
  /// [copyWith] method for [InternetAddress]
  InternetAddress copyWith({String? host, int? port, Duration? timeOut}) =>
      InternetAddress(
          host: host ?? this.host,
          port: port ?? this.port,
          timeOut: timeOut ?? this.timeOut);
}
