import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Write/Model/MyWriteModel.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:openmind_app/shared/ColorExt.dart';

class WriteDetailScreen extends StatelessWidget {
  final MyWriteModel writeModel;

  const WriteDetailScreen({Key? key, required this.writeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        centerTitle: false,
        title: Text(
          writeModel.title,
          style: AppFont.bold(20).copyWith(color: Colors.black87),
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Text(
          writeModel.content,
          style: AppFont.medium(16).copyWith(color: Colors.black87, height: 1.6),
        ),
      ),
    );
  }
}
