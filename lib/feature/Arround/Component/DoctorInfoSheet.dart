import 'package:flutter/material.dart';
import 'package:openmind_app/feature/Arround/Model/DoctorModel.dart';
import 'package:openmind_app/feature/Message/MessageScreen.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

class DoctorInfoSheet extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorInfoSheet({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(doctor.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(doctor.name, style: AppFont.bold(22)),
          SizedBox(height: 12),
          Text(
            "오전 7시부터 오후 9시 까지 활동합니다~",
            textAlign: TextAlign.center,
            style: AppFont.regular(14, color: Colors.grey[600]),
          ),
          SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.main,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.pop(context); // 먼저 시트 닫기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MessageScreen(
                      counselorName: doctor.name,
                    ),
                  ),
                );
              },
              child: Text("채팅하기", style: AppFont.bold(16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
