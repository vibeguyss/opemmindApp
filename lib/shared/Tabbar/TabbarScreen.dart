import 'package:flutter/material.dart';
import 'package:openmind_app/feature/AI/AIScreen.dart';
import 'package:openmind_app/feature/Home/HomeScreen.dart';
import 'package:openmind_app/feature/Message/MessageScreen.dart';
import 'package:openmind_app/feature/Profile/ProfileScreen.dart';
import 'package:openmind_app/feature/Write/WriteScreen.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/Tabbar/OpenmindTabbar.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({Key? key}) : super(key: key);

  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
    WriteScreen(),
    AIScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg(context),
      body: _pages[_currentIndex],
      bottomNavigationBar: OpenmindTabbar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        onAITap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AIScreen()),
          );
        },
      ),
    );
  }
}