import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Auth/Model/RoleEnum.dart';
import 'package:openmind_app/shared/Api/ApiClient.dart';
import 'package:openmind_app/shared/Api/BaseResponse.dart';
import 'package:openmind_app/shared/Tabbar/TabbarScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Model/LoginModel.dart';
import '../Model/TokenModel.dart';

class AuthViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RoleEnum selectedRole = RoleEnum.user;
  final ApiClient apiClient = ApiClient();

  void setUserRole(RoleEnum role) {
    selectedRole = role;
    notifyListeners();
  }

  LoginModel get loginData => LoginModel(
    name: nameController.text.trim(),
    email: emailController.text.trim(),
    password: passwordController.text,
    userRole: selectedRole,
  );

  Future<void> login(BuildContext context) async {
    try {
      final loginInfo = loginData;
      print('로그인 요청 시도');

      final response = await apiClient.post(
        '/auth/sign-in',
        body: {
          'email': loginInfo.email,
          'password': loginInfo.password,
        },
        withToken: false,
      );

      print('로그인 응답 statusCode: ${response.statusCode}');
      print('로그인 응답 body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonMap = jsonDecode(response.body);
        final tokenJson = jsonMap['data'];
        final token = TokenModel.fromJson(tokenJson);

        print("✅ 로그인 성공: ${token.accessToken}");

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', token.accessToken);
        await prefs.setString('refreshToken', token.refreshToken);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 성공!', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => TabbarScreen()),
        );
      } else {
        _showError(context, "이메일 또는 비밀번호를 확인해주세요.");
      }
    } catch (e) {
      print("❌ 로그인 네트워크 오류: $e");
      _showError(context, "서버 연결에 실패했습니다.");
    }
  }

  Future<void> signUp(BuildContext context) async {
    try {
      final signupInfo = loginData;

      final response = await apiClient.post(
        '/auth/sign-up',
        body: {
          'name': signupInfo.name,
          'email': signupInfo.email,
          'password': signupInfo.password,
          'userRole': signupInfo.userRole.value,
        },
        withToken: false,
      );

      print('회원가입 응답 statusCode: ${response.statusCode}');
      print('회원가입 응답 body: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final baseResponse = BaseResponse<String>.fromJson(
          jsonDecode(response.body),
              (json) => json as String,
        );

        print('회원가입 응답 메시지: ${baseResponse.data}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('회원가입 성공!', style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pop();
      } else {
        _showError(context, "회원가입에 실패했습니다. 다시 시도해주세요.");
      }
    } catch (e) {
      print("❌ 회원가입 네트워크 오류: $e");
      _showError(context, "서버 연결에 실패했습니다.");
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
    );
  }

  void initControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken') != null;
  }
}