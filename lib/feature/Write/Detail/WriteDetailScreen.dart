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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              writeModel.content,
              style: AppFont.medium(16).copyWith(color: Colors.black87, height: 1.7),
            ),
            const SizedBox(height: 40),

            Text(
              "🤖 AI의 한마디",
              style: AppFont.bold(18).copyWith(color: Colors.black87),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                "친구와 산책하고 맛있는 라면까지!\n오늘 하루가 꽤 힐링되었을 것 같아요 ☀️\n\n다음엔 좋아하는 음악을 들으며 혼자만의 시간을 보내보는 건 어떨까요? 😊",
                style: AppFont.medium(15).copyWith(
                  color: Colors.black87,
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
