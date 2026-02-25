import 'dart:async';
import 'dart:io';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'mqtt_exceptions.dart';
import 'mqtt_state.dart';

part 'mqtt_manager.g.dart';

@Riverpod(keepAlive: true)
class MqttManager extends _$MqttManager {
  MqttServerClient? _client;
  StreamSubscription? _messageSubscription;

  @override
  MqttState build() => const MqttState();

  Future<void> connect({
    required String host,
    required int port,
    required String clientId,
    String? username,
    String? password,
  }) async {
    state = state.copyWith(
      connectionStatus: MqttConnectionStatus.connecting,
      errorMessage: null,
    );

    try {
      _client = MqttServerClient.withPort(host, clientId, port);
      _client!.keepAlivePeriod = 20;
      _client!.connectTimeoutPeriod = 10000;
      _client!.onDisconnected = _onDisconnected;
      _client!.secure = true;
      _client!.setProtocolV311();
      _client!.logging(on: true);
      _client!.securityContext = SecurityContext(withTrustedRoots: false);
      _client!.onBadCertificate = (dynamic cert) => true;

      final connMessage = MqttConnectMessage()
          .withClientIdentifier(clientId)
          .startClean()
          .authenticateAs(username, password);

      _client!.connectionMessage = connMessage;

      await _client!.connect(username, password);

      if (_client!.connectionStatus?.state == MqttConnectionState.connected) {
        state = state.copyWith(connectionStatus: MqttConnectionStatus.connected);
        _listenToMessages();
      } else {
        final returnCode = _client!.connectionStatus?.returnCode;
        _client!.disconnect();
        _client = null;

        if (returnCode == MqttConnectReturnCode.notAuthorized ||
            returnCode == MqttConnectReturnCode.badUsernameOrPassword) {
          throw const MqttAuthenticationException('Invalid username or password');
        }
        throw MqttConnectionException(
          'Connection failed: ${returnCode?.name ?? 'unknown'}',
        );
      }
    } on MqttAuthenticationException {
      state = state.copyWith(
        connectionStatus: MqttConnectionStatus.error,
        errorMessage: 'Authentication failed',
      );
      rethrow;
    } on MqttConnectionException catch (e) {
      state = state.copyWith(
        connectionStatus: MqttConnectionStatus.error,
        errorMessage: e.message,
      );
      rethrow;
    } catch (e) {
      _client?.disconnect();
      _client = null;
      final message = e.toString();
      state = state.copyWith(
        connectionStatus: MqttConnectionStatus.error,
        errorMessage: message.contains('SocketException') || message.contains('timed out')
            ? 'Connection timed out. Check host and port.'
            : message,
      );
    }
  }

  void disconnect() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
    _client?.disconnect();
    _client = null;
    state = const MqttState();
  }

  void subscribe(String topic) {
    if (_client == null || state.connectionStatus != MqttConnectionStatus.connected) return;
    if (state.subscribedTopics.contains(topic)) return;

    _client!.subscribe(topic, MqttQos.atLeastOnce);
    state = state.copyWith(
      subscribedTopics: [...state.subscribedTopics, topic],
    );
  }

  void unsubscribe(String topic) {
    if (_client == null) return;
    _client!.unsubscribe(topic);
    state = state.copyWith(
      subscribedTopics: state.subscribedTopics.where((t) => t != topic).toList(),
    );
  }

  void publish(String topic, String message) {
    if (_client == null || state.connectionStatus != MqttConnectionStatus.connected) return;

    final builder = MqttClientPayloadBuilder()..addString(message);
    _client!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  void clearMessages() {
    state = state.copyWith(messages: []);
  }

  void _listenToMessages() {
    _messageSubscription = _client!.updates!.listen(
      (List<MqttReceivedMessage<MqttMessage>> messages) {
        for (final message in messages) {
          final publish = message.payload as MqttPublishMessage;
          final payload = MqttPublishPayload.bytesToStringAsString(
            publish.payload.message,
          );
          final received = MqttLogEntry(
            topic: message.topic,
            payload: payload,
            timestamp: DateTime.now(),
          );
          state = state.copyWith(messages: [received, ...state.messages]);
        }
      },
    );
  }

  void _onDisconnected() {
    _messageSubscription?.cancel();
    _messageSubscription = null;
    state = state.copyWith(
      connectionStatus: MqttConnectionStatus.disconnected,
      subscribedTopics: [],
    );
  }
}
