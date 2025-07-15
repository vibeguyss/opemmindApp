import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Keep if you still use http directly elsewhere, otherwise can remove
import 'package:openmind_app/feature/Arround/Model/DoctorModel.dart';
import 'package:openmind_app/shared/Api/ApiClient.dart';
import 'package:openmind_app/shared/Api/BaseResponse.dart'; // Import BaseResponse

class DoctorViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<DoctorModel> doctors = [];
  final ApiClient apiClient = ApiClient();

  Future<void> fetchDoctors() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiClient.get('/daily/doctor', withToken: true);

      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final baseResponse = BaseResponse<List<DoctorModel>>.fromJson(
          jsonDecode(decodedBody),
              (jsonList) => (jsonList as List)
              .map((item) => DoctorModel.fromJson(item as Map<String, dynamic>))
              .toList(),
        );

        if (baseResponse.data != null) {
          doctors = baseResponse.data!;
        } else {
          doctors = [];
        }
      } else {
        final errorResponse = BaseResponse<String>.fromJson(
          jsonDecode(decodedBody),
              (json) => json.toString(),
        );
        print("❌ 의사 정보 가져오기 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("네트워크 오류 또는 데이터 처리 오류가 발생했습니다: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}