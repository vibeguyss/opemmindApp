import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();
  static const Color main = Color(0xff7BA2DF);
  static const Color disable = Color(0xff5C6572);

  static Color bg(BuildContext context) =>
      Theme.of(context).scaffoldBackgroundColor;

  static Color text(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;

  static Color textSecondary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[400]!
          : Colors.grey[600]!;
}