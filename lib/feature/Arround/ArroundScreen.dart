import 'package:flutter/material.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

class ArroundScreen extends StatelessWidget {
  const ArroundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        centerTitle: false,
        title: Text("상담원 둘러보기", style: AppFont.bold(20)),
      ),
    );
  }
}
