import 'package:flutter/cupertino.dart';
import 'package:openmind_app/feature/Profile/Model/UserModel.dart';
import 'package:openmind_app/shared/Api/ApiClient.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  final ApiClient apiClient = ApiClient();

  UserModel? userData;

  Future<void> fetchMyData(BuildContext context) async {
    try {
      final response = await apiClient.get(
        '/user/me',
        withToken: true,
      );

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final userJson = jsonMap['data'];
        userData = UserModel.fromJson(userJson);
        notifyListeners(); // UI 반영
      } else {
        print("❌ 사용자 정보 가져오기 실패: ${response.statusCode}");
      }
    } catch (e) {
      print("❌ 네트워크 오류: $e");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    notifyListeners();
  }
}
