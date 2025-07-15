import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openmind_app/shared/Tabbar/TabbarScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: TabbarScreen(),
    );
  }
}
