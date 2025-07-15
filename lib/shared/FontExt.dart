import 'package:flutter/material.dart';

class AppFont {
  static TextStyle extraBold(double size, {Color? color}) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w800,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle bold(double size, {Color? color}) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w700,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle semiBold(double size, {Color? color}) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle medium(double size, {Color? color}) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle regular(double size, {Color? color}) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400,
      fontSize: size,
      color: color,
    );
  }

  static TextStyle light(double size, {Color? color}) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w300,
      fontSize: size,
      color: color,
    );
  }
}