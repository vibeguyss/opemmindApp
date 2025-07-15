// lib/shared/TossInputField.dart
import 'package:flutter/material.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon; // 선택 사항: 비밀번호 보이기/숨기기 아이콘 등

  const InputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false, // 기본값 false
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: AppFont.bold(18, color: Colors.black87), // 입력 텍스트 스타일
      cursorColor: AppColor.main, // 커서 색상
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppFont.regular(18, color: Colors.black38), // 힌트 텍스트 스타일
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0), // 좌우 패딩 제거
        suffixIcon: suffixIcon, // suffixIcon 적용
        // 토스 스타일: 밑줄만 있는 필드
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0), // 얇은 밑줄
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColor.main, width: 2.0), // 포커스 시 메인 색상 밑줄
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade600, width: 1.0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade600, width: 2.0),
        ),
        filled: false, // 배경색 채우지 않음
        errorStyle: AppFont.regular(12, color: Colors.red.shade600), // 에러 메시지 스타일
      ),
    );
  }
}