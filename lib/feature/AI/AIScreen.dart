import 'package:flutter/material.dart';
import 'package:openmind_app/shared/IconExt.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppIcon.home.toIcon(width: 30, height: 30)),
    );
    ;
  }
}
