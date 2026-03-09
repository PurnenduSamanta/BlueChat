import 'package:flutter/foundation.dart';

import '../model/chat_message.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  void sendMessage(String text) {
    if (text.trim().isEmpty) {
      return;
    }

    _messages.add(
      ChatMessage(text: text.trim(), timestamp: DateTime.now(), isFromMe: true),
    );
    notifyListeners();
  }
}
