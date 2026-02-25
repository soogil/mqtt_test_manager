import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/mqtt/mqtt_manager.dart';

part 'mqtt_tester_view_model.g.dart';

@riverpod
class MqttTesterViewModel extends _$MqttTesterViewModel {
  @override
  void build() {}

  Future<void> connect({
    required String host,
    required int port,
    required String clientId,
    String? username,
    String? password,
  }) async {
    await ref.read(mqttManagerProvider.notifier).connect(
          host: host,
          port: port,
          clientId: clientId,
          username: username,
          password: password,
        );
  }

  void disconnect() => ref.read(mqttManagerProvider.notifier).disconnect();

  void subscribe(String topic) {
    if (topic.trim().isEmpty) return;
    ref.read(mqttManagerProvider.notifier).subscribe(topic.trim());
  }

  void unsubscribe(String topic) {
    ref.read(mqttManagerProvider.notifier).unsubscribe(topic);
  }

  void publish(String topic, String message) {
    if (topic.trim().isEmpty) return;
    ref.read(mqttManagerProvider.notifier).publish(topic.trim(), message);
  }

  void clearMessages() => ref.read(mqttManagerProvider.notifier).clearMessages();
}
