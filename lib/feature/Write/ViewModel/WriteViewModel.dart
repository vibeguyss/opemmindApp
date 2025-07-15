import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openmind_app/feature/Write/Model/MyWriteModel.dart';

class WriteViewModel extends ChangeNotifier {
  List<MyWriteModel> _myWritings = [];
  bool isLoading = false;

  List<MyWriteModel> get myWritings => _myWritings;

  Future<void> fetchMyWrite() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://your.api/my-diary'));

      if (response.statusCode == 200) {
        final List jsonList = jsonDecode(response.body);
        _myWritings = jsonList
            .map((json) => MyWriteModel.fromJson(json))
            .toList();
      } else {
        print("❌ Failed to load diary list: ${response.statusCode}");
        // 실패 시 더미 데이터 넣기
        _setDummyData();
      }
    } catch (e) {
      print("❌ 네트워크 오류 발생: $e");
      // 예외 시 더미 데이터 넣기
      _setDummyData();
    }

    isLoading = false;
    notifyListeners();
  }

  void _setDummyData() {
    _myWritings = [
      MyWriteModel(dailyId: 1, title: "첫 번째 일기", content: "오늘은 정말 좋은 날이었다."),
      MyWriteModel(dailyId: 2, title: "두 번째 일기", content: "Flutter 공부를 시작했다."),
      MyWriteModel(dailyId: 3, title: "세 번째 일기", content: "친구들과 즐거운 시간을 보냈다."),
    ];
  }

  Future<MyWriteModel?> writePost(String title, String content) async {
    final response = await http.post(
      Uri.parse('https://your.api/diary'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'content': content,
      }),
    );

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
      final newDiary = MyWriteModel.fromJson(json);
      _myWritings.insert(0, newDiary);
      notifyListeners();
      return newDiary;
    } else {
      print("❌ Failed to post diary: ${response.statusCode}");
      return null;
    }
  }
}
