import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:openmind_app/feature/Component/SearchTextField.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:openmind_app/shared/IconExt.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _searchText = "";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _searchText = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.background,
            centerTitle: false,
            title: Text(
              "OPENMIND",
              style: AppFont.bold(20),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  print("알림");
                },
                icon: AppIcon.bell.toIcon(),
              ),
            ],
          ),

          CupertinoSliverRefreshControl(
            onRefresh: () async {
              print("스크롤");
            },
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                height: 40,
                child: SearchTextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
