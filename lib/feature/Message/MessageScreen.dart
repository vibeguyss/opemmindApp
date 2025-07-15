import 'package:flutter/material.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        centerTitle: false,
        title: Text("채팅 목록", style: AppFont.bold(20)),
      ),
    );
  }
}
