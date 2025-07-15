import 'package:flutter/material.dart';

class WriteViewModel extends ChangeNotifier {
  String title = '';
  String content = '';

  void updateTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }

  void updateContent(String newContent) {
    content = newContent;
    notifyListeners();
  }

  Future<void> saveDiary() async {
    print("🔁 서버로 전송 중: $title, $content");

  }
}
