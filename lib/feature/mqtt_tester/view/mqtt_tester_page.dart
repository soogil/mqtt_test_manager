import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mqtt/mqtt_manager.dart';
import '../../../core/mqtt/mqtt_state.dart';
import '../mqtt_tester_view_model.dart';
import 'widgets/message_log_widget.dart';

class MqttTesterPage extends ConsumerStatefulWidget {
  const MqttTesterPage({super.key});

  @override
  ConsumerState<MqttTesterPage> createState() => _MqttTesterPageState();
}

class _MqttTesterPageState extends ConsumerState<MqttTesterPage> {
  final _hostCtrl = TextEditingController(text: '76ccee16bbf34dd2a99f07cbe3d8808a.s1.eu.hivemq.cloud');
  final _portCtrl = TextEditingController(text: '8883');
  final _usernameCtrl = TextEditingController(text: 'soogil');
  final _passwordCtrl = TextEditingController(text: 'Soflau159');
  final _clientIdCtrl = TextEditingController(text: 'mqtt_${DateTime.now().millisecondsSinceEpoch}');
  final _subTopicCtrl = TextEditingController(text: 'test/topic');
  final _pubTopicCtrl = TextEditingController(text: 'test/topic');
  final _pubMsgCtrl = TextEditingController(text: 'Test Flutter MQTT!');

  @override
  void dispose() {
    _hostCtrl.dispose();
    _portCtrl.dispose();
    _clientIdCtrl.dispose();
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    _subTopicCtrl.dispose();
    _pubTopicCtrl.dispose();
    _pubMsgCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mqttState = ref.watch(mqttManagerProvider);
    final vm = ref.read(mqttTesterViewModelProvider.notifier);
    final isConnected = mqttState.connectionStatus == MqttConnectionStatus.connected;
    final isConnecting = mqttState.connectionStatus == MqttConnectionStatus.connecting;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MQTT Tester'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (mqttState.messages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              tooltip: 'Clear messages',
              onPressed: vm.clearMessages,
            ),
        ],
      ),
      body: Column(
        children: [
          _StatusBar(status: mqttState.connectionStatus, error: mqttState.errorMessage),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SectionCard(
                    title: 'Broker Connection',
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _Field(
                                label: 'Host',
                                controller: _hostCtrl,
                                enabled: !isConnected && !isConnecting,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _Field(
                                label: 'Port',
                                controller: _portCtrl,
                                keyboardType: TextInputType.number,
                                enabled: !isConnected && !isConnecting,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _Field(
                          label: 'Client ID',
                          controller: _clientIdCtrl,
                          enabled: !isConnected && !isConnecting,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: _Field(
                                label: 'Username (optional)',
                                controller: _usernameCtrl,
                                enabled: !isConnected && !isConnecting,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _Field(
                                label: 'Password (optional)',
                                controller: _passwordCtrl,
                                obscureText: true,
                                enabled: !isConnected && !isConnecting,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton.icon(
                                onPressed: isConnected || isConnecting
                                    ? null
                                    : () => vm.connect(
                                          host: _hostCtrl.text,
                                          port: int.tryParse(_portCtrl.text) ?? 1883,
                                          clientId: _clientIdCtrl.text,
                                          username: _usernameCtrl.text.isEmpty ? null : _usernameCtrl.text,
                                          password: _passwordCtrl.text.isEmpty ? null : _passwordCtrl.text,
                                        ),
                                icon: isConnecting
                                    ? const SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(Icons.link),
                                label: Text(isConnecting ? 'Connecting...' : 'Connect'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: isConnected ? vm.disconnect : null,
                                icon: const Icon(Icons.link_off),
                                label: const Text('Disconnect'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Subscribe',
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _Field(
                                label: 'Topic',
                                controller: _subTopicCtrl,
                                enabled: isConnected,
                              ),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              onPressed: isConnected
                                  ? () => vm.subscribe(_subTopicCtrl.text)
                                  : null,
                              child: const Text('Subscribe'),
                            ),
                          ],
                        ),
                        if (mqttState.subscribedTopics.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: mqttState.subscribedTopics.map((t) {
                              return Chip(
                                label: Text(t, style: const TextStyle(fontSize: 12)),
                                deleteIcon: const Icon(Icons.close, size: 16),
                                onDeleted: () => vm.unsubscribe(t),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Publish',
                    child: Column(
                      children: [
                        _Field(
                          label: 'Topic',
                          controller: _pubTopicCtrl,
                          enabled: isConnected,
                        ),
                        const SizedBox(height: 8),
                        _Field(
                          label: 'Message',
                          controller: _pubMsgCtrl,
                          enabled: isConnected,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: isConnected
                                ? () => vm.publish(_pubTopicCtrl.text, _pubMsgCtrl.text)
                                : null,
                            icon: const Icon(Icons.send),
                            label: const Text('Publish'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _SectionCard(
                    title: 'Message Log (${mqttState.messages.length})',
                    child: SizedBox(
                      height: 300,
                      child: const MessageLogWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  final MqttConnectionStatus status;
  final String? error;

  const _StatusBar({required this.status, this.error});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      MqttConnectionStatus.connected => ('Connected', Colors.green),
      MqttConnectionStatus.connecting => ('Connecting...', Colors.orange),
      MqttConnectionStatus.error => ('Error: ${error ?? 'unknown'}', Colors.red),
      MqttConnectionStatus.disconnected => ('Disconnected', Colors.grey),
    };

    print(error);

    return Container(
      width: double.infinity,
      color: color.withValues(alpha: 0.15),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13),
              // overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;

  const _Field({
    required this.label,
    required this.controller,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
