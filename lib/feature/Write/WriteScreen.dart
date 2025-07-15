import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Write/Component/MyWriteListComponent.dart';
import 'package:openmind_app/feature/Write/Edit/WriteEditScreen.dart';
import 'package:openmind_app/feature/Write/Model/MyWriteModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:openmind_app/shared/IconExt.dart';

class WriteScreen extends StatelessWidget {
  const WriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 더미 데이터
    final List<MyWriteModel> dummyList = [
      MyWriteModel(dailyId: 1, title: "첫 번째 일기", content: "오늘은 정말 좋은 날이었다."),
      MyWriteModel(dailyId: 2, title: "두 번째 일기", content: "Flutter 공부를 시작했다."),
      MyWriteModel(dailyId: 3, title: "세 번째 일기", content: "친구들과 즐거운 시간을 보냈다."),
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        centerTitle: false,
        title: Text("내 일기", style: AppFont.bold(20)),
      ),
      body: MyWriteListComponent(items: dummyList),  // 여기에 리스트 컴포넌트 넣음
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.main,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WriteEditScreen()),
          );
        },
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
