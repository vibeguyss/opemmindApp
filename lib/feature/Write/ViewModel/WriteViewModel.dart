import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openmind_app/feature/Write/Model/MyWriteModel.dart';
import 'package:openmind_app/shared/Api/ApiClient.dart';

class WriteViewModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<MyWriteModel> _myWritings = [];
  final ApiClient apiClient = ApiClient();
  bool isLoading = false;

  List<MyWriteModel> get myWritings => _myWritings;

  Future<void> fetchMyWrite() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.get(
        '/daily',
        withToken: true,
      );

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final data = jsonMap['data'];

        if (data is List) {
          _myWritings = data.map((e) => MyWriteModel.fromJson(e)).toList();
          print("✅ 일기 불러오기 성공: ${_myWritings.length}개");
        } else {
          print("❗️data가 배열이 아님: $data");
        }
      } else {
        print("❌ 서버 응답 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ 네트워크 오류: $e");
    }

    isLoading = false;
    notifyListeners();
  }


  Future<void> writePost() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) return;

    isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.post(
        '/daily',
        body: {"title": title, "content": content},
        withToken: true,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonMap = jsonDecode(response.body);

        if (jsonMap['status'] == 200 && jsonMap['data'] != null) {
          final userJson = jsonMap['data'];
          final model = MyWriteModel.fromJson(userJson);
          print("✅ 저장 성공: ${model.dailyId}");
        } else {
          print("❌ 응답 구조 오류 또는 status != 200: $jsonMap");
        }
      } else {
        print("❌ HTTP 오류: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ 저장 중 오류: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}
