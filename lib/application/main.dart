import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:openmind_app/feature/Write/ViewModel/WriteViewModel.dart';
import 'package:openmind_app/shared/Tabbar/TabbarScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WriteViewModel(),
      child: const MyApp(),
    ),
  );
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
