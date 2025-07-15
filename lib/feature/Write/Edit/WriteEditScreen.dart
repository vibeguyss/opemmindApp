import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Write/ViewModel/WriteViewModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';

class WriteEditScreen extends StatelessWidget {
  const WriteEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WriteViewModel>(context);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text("일기 작성", style: AppFont.bold(18)),
        backgroundColor: AppColor.background,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              viewModel.saveDiary();
              Navigator.pop(context);
            },
            child: Text("저장", style: AppFont.bold(16, color: AppColor.main)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: viewModel.updateTitle,
              style: AppFont.bold(16),
              decoration: InputDecoration(
                hintText: "제목을 입력하세요",
                border: InputBorder.none,
              ),
            ),
            Divider(),
            Expanded(
              child: TextField(
                onChanged: viewModel.updateContent,
                maxLines: null,
                expands: true,
                style: AppFont.regular(15),
                decoration: InputDecoration(
                  hintText: "오늘의 이야기를 들려주세요...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
