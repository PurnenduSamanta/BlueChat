import 'package:flutter/material.dart';

import '../model/chat_message.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bubbleColor = message.isFromMe ? scheme.primary : scheme.surface;
    final textColor = message.isFromMe ? scheme.onPrimary : scheme.onSurface;
    final alignment = message.isFromMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(message.text, style: TextStyle(color: textColor)),
        ),
      ],
    );
  }
}
