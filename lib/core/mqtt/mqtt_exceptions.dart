class MqttConnectionTimeoutException implements Exception {
  final String message;
  const MqttConnectionTimeoutException(this.message);

  @override
  String toString() => 'MqttConnectionTimeoutException: $message';
}

class MqttAuthenticationException implements Exception {
  final String message;
  const MqttAuthenticationException(this.message);

  @override
  String toString() => 'MqttAuthenticationException: $message';
}

class MqttConnectionException implements Exception {
  final String message;
  const MqttConnectionException(this.message);

  @override
  String toString() => 'MqttConnectionException: $message';
}
