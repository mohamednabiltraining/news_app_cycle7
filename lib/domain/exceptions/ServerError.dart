class ServerError implements Exception {
  String message;

  ServerError(this.message);

  @override
  String toString() => "FormatException: $message";
}
