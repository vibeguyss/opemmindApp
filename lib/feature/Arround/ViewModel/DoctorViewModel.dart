import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openmind_app/feature/Arround/Model/DoctorModel.dart';

class DoctorViewModel extends ChangeNotifier {
  bool isLoading = true;
  List<DoctorModel> doctors = [];

  DoctorViewModel() {
    fetchDoctors();
  }

  Future<void> fetchDoctors() async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 1)); // 더미 데이터 로딩 대기

    // 더미 데이터
    doctors = [
      DoctorModel(userId: 1, name: "김상담", imageUrl: "https://randomuser.me/api/portraits/men/1.jpg"),
      DoctorModel(userId: 2, name: "이상담", imageUrl: "https://randomuser.me/api/portraits/women/2.jpg"),
      DoctorModel(userId: 3, name: "박상담", imageUrl: "https://randomuser.me/api/portraits/men/3.jpg"),
    ];

    isLoading = false;
    notifyListeners();

    /*
  try {
    // 실제 API 주소로 교체하세요
    final response = await http.get(Uri.parse('https://your.api/doctors'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      doctors = jsonList.map((json) => DoctorModel.fromJson(json)).toList();
    } else {
      print("❌ 서버 응답 오류: ${response.statusCode}");
      doctors = [];
    }
  } catch (e) {
    print("❌ 네트워크 오류: $e");
    doctors = [];
  }

  isLoading = false;
  notifyListeners();
  */
  }
}
