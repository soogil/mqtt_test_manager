import 'package:freezed_annotation/freezed_annotation.dart';

part 'mqtt_state.freezed.dart';

enum MqttConnectionStatus { disconnected, connecting, connected, error }

@freezed
class MqttState with _$MqttState {
  const factory MqttState({
    @Default(MqttConnectionStatus.disconnected) MqttConnectionStatus connectionStatus,
    @Default([]) List<MqttLogEntry> messages,
    @Default([]) List<String> subscribedTopics,
    String? errorMessage,
  }) = _MqttState;
}

@freezed
class MqttLogEntry with _$MqttLogEntry {
  const factory MqttLogEntry({
    required String topic,
    required String payload,
    required DateTime timestamp,
  }) = _MqttLogEntry;
}
