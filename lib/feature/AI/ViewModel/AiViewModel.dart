import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openmind_app/feature/AI/Model/AiResponse.dart';

class AiViewModel extends ChangeNotifier {
  List<_ChatMessage> messages = [];
  bool isLoading = false;

  final String _apiUrl = "http://54.79.145.51:8000/chat";

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;

    messages.add(_ChatMessage(text: text, isUser: true));
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'prompt': text}), // 서버가 'prompt' 키를 예상하는 경우
      );

      if (response.statusCode == 200) {
        String decodedBody;
        try {
          decodedBody = utf8.decode(response.bodyBytes);
        } catch (e) {
          print('❌ UTF-8 디코딩 오류: $e');
          messages.add(_ChatMessage(text: "오류: 응답 디코딩 실패", isUser: false));
          return;
        }

        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = jsonDecode(decodedBody);
        } catch (e) {
          print('❌ JSON 파싱 오류: $e | 응답 본문: "$decodedBody"');
          messages.add(_ChatMessage(text: "오류: 응답 파싱 실패", isUser: false));
          return;
        }

        // AiResponse 모델을 사용하여 응답을 파싱합니다.
        final aiResponseObject = AiResponse.fromJson(jsonResponse);
        final String aiMessage = aiResponseObject.response; // AiResponse에서 response 필드를 가져옵니다.

        if (aiMessage.isNotEmpty) { // aiMessage는 String이므로 null 체크는 필요 없습니다.
          messages.add(_ChatMessage(text: aiMessage, isUser: false));
        } else {
          messages.add(_ChatMessage(text: "AI 응답 없음 (내용 비어있음)", isUser: false));
        }

      } else {
        print('❌ HTTP Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        messages.add(_ChatMessage(
            text: "오류: 서버 응답 (${response.statusCode})", isUser: false));
      }
    } catch (e) {
      print('❌ 네트워크/요청 오류: $e');
      messages.add(_ChatMessage(text: "오류: 네트워크 연결 또는 요청 실패", isUser: false));
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;

  _ChatMessage({required this.text, required this.isUser});
}