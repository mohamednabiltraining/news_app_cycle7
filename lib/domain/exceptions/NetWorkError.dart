class NetWorkError implements Exception {
  String message;

  NetWorkError(this.message);

  @override
  String toString() => "FormatException: $message";
}
