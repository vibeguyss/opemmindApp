import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:openmind_app/feature/AI/Model/AiModel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AiViewModel extends ChangeNotifier {

  late WebSocketChannel _channel;
  List<_ChatMessage> messages = [];
  bool isConnected = false;


  void _connect() {
    _channel = WebSocketChannel.connect(Uri.parse("url"));

    _channel.stream.listen(
          (data) {
        final json = jsonDecode(data);
        final aiMessage = AiModel.fromJson(json).prompt;
        messages.add(_ChatMessage(text: aiMessage, isUser: false));
        notifyListeners();
      },
      onDone: () {
        isConnected = false;
        notifyListeners();
      },
      onError: (error) {
        isConnected = false;
        notifyListeners();
      },
    );
    isConnected = true;
    notifyListeners();
  }

  void sendMessage(String text) {
    if (!isConnected) {
      _connect();
    }
    if (isConnected) {
      final json = jsonEncode({'prompt': text});
      _channel.sink.add(json);
      messages.add(_ChatMessage(text: text, isUser: true));
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}
