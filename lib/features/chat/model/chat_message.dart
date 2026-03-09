class ChatMessage {
  final String text;
  final DateTime timestamp;
  final bool isFromMe;

  const ChatMessage({
    required this.text,
    required this.timestamp,
    required this.isFromMe,
  });
}
