import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Write/ViewModel/WriteViewModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:provider/provider.dart';

class WriteEditScreen extends StatefulWidget {
  const WriteEditScreen({Key? key}) : super(key: key);

  @override
  State<WriteEditScreen> createState() => _WriteEditScreenState();
}

class _WriteEditScreenState extends State<WriteEditScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<WriteViewModel>();

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text("일기 작성", style: AppFont.bold(18)),
        backgroundColor: AppColor.background,
        elevation: 0,
        actions: [
          viewModel.isLoading
              ? Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColor.main,
              ),
            ),
          )
              : TextButton(
            onPressed: () async {
              final title = _titleController.text.trim();
              final content = _contentController.text.trim();

              if (title.isEmpty || content.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("제목과 내용을 모두 입력해주세요.")),
                );
                return;
              }

              await viewModel.writePost(title, content);
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
              controller: _titleController,
              style: AppFont.bold(16),
              decoration: InputDecoration(
                hintText: "제목을 입력하세요",
                border: InputBorder.none,
              ),
            ),
            Divider(),
            Expanded(
              child: TextField(
                controller: _contentController,
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
