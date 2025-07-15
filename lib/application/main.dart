import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:openmind_app/feature/AI/ViewModel/AiViewModel.dart';
import 'package:openmind_app/feature/Arround/ViewModel/DoctorViewModel.dart';
import 'package:openmind_app/feature/Auth/LoginScreen.dart';
import 'package:openmind_app/feature/Auth/ViewModel/AuthViewModel.dart';
import 'package:openmind_app/feature/Write/ViewModel/WriteViewModel.dart';
import 'package:openmind_app/shared/Tabbar/TabbarScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isLoggedIn = await AuthViewModel.isLoggedIn(); // 토큰 존재 여부 확인

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WriteViewModel()),
        ChangeNotifierProvider(create: (_) => DoctorViewModel()),
        ChangeNotifierProvider(create: (_) => AiViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const TabbarScreen() : const LoginScreen(),
    );
  }
}
