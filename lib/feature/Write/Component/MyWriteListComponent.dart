import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Write/Detail/WriteDetailScreen.dart';
import 'package:openmind_app/feature/Write/Model/MyWriteModel.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

class MyWriteListComponent extends StatelessWidget {
  final List<MyWriteModel> items;

  const MyWriteListComponent({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WriteDetailScreen(writeModel: item),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: AppFont.bold(16).copyWith(color: AppColor.main),
                ),
                SizedBox(height: 6),
                Text(
                  item.content,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppFont.regular(14).copyWith(color: Colors.black87),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
