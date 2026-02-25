import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/mqtt/mqtt_manager.dart';
import '../../../../core/mqtt/mqtt_state.dart';

class MessageLogWidget extends ConsumerWidget {
  const MessageLogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(mqttManagerProvider.select((s) => s.messages));

    if (messages.isEmpty) {
      return const Center(
        child: Text(
          'No messages yet.\nSubscribe to a topic to receive messages.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      reverse: false,
      itemCount: messages.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final msg = messages[index];
        return _MessageTile(message: msg);
      },
    );
  }
}

class _MessageTile extends StatelessWidget {
  final MqttLogEntry message;

  const _MessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time =
        '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}:${message.timestamp.second.toString().padLeft(2, '0')}';

    return ListTile(
      dense: true,
      leading: Text(
        time,
        style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
      ),
      title: Text(
        message.topic,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        message.payload,
        style: theme.textTheme.bodyMedium,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
