import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Keep if still needed elsewhere, otherwise can remove
import 'package:openmind_app/feature/Write/Model/MyWriteModel.dart';
import 'package:openmind_app/shared/Api/ApiClient.dart';
import 'package:openmind_app/shared/Api/BaseResponse.dart'; // Import BaseResponse

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

      // Decode the response body using UTF-8
      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final baseResponse = BaseResponse<List<dynamic>>.fromJson(
          jsonDecode(decodedBody),
              (json) => json as List<dynamic>,
        );

        if (baseResponse.data != null) {
          _myWritings = baseResponse.data!
              .map((e) => MyWriteModel.fromJson(e as Map<String, dynamic>))
              .toList();
          print("✅ 일기 불러오기 성공: ${_myWritings.length}개");
        } else {
          _myWritings = []; // No data returned
        }
      } else {
        // Handle API errors based on status code
        final errorResponse = BaseResponse<String>.fromJson(
          jsonDecode(decodedBody),
              (json) => json.toString(), // Assuming error message is a string
        );
        _myWritings = []; // Clear writings on error
      }
    } catch (e) {
      _myWritings = []; // Clear writings on error
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  Future<bool> writePost() async { // Changed return type to bool for success/failure
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.post(
        '/daily',
        body: {"title": title, "content": content},
        withToken: true,
      );

      // Decode the response body using UTF-8
      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final baseResponse = BaseResponse<Map<String, dynamic>>.fromJson(
          jsonDecode(decodedBody),
              (json) => json as Map<String, dynamic>, // Assuming data is a single object for a new post
        );

        if (baseResponse.data != null) {
          final model = MyWriteModel.fromJson(baseResponse.data!);
          print("✅ 일기 저장 성공: ${model.dailyId}");
          // Optionally, add the new post to _myWritings if you want to update the list immediately
          // _myWritings.insert(0, model); // Add to the beginning
          // notifyListeners();
          return true; // Indicate success
        } else {
          print("❌ 응답 데이터 오류: $decodedBody");
          return false;
        }
      } else {
        final errorResponse = BaseResponse<String>.fromJson(
          jsonDecode(decodedBody),
              (json) => json.toString(),
        );
        print("❌ HTTP 오류: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }
}