import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:openmind_app/feature/AI/AIScreen.dart';
import 'package:openmind_app/feature/Component/SearchTextField.dart';
import 'package:openmind_app/feature/Home/Component/expanded_section_card.dart';
import 'package:openmind_app/feature/Message/MessageScreen.dart';
import 'package:openmind_app/feature/Write/WriteScreen.dart';
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
            title: Text("OPENMIND", style: AppFont.bold(20)),
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

          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ExpandedSectionCard(
                  headerText: "새로운 마음을 찾아요",
                  title: "AI랑 상담하러 가기",
                  headerIcon: Icons.psychology_outlined,
                  headerIconColor: Colors.black,
                  cardColor: Colors.white,
                  titleTextColor: Colors.black,
                  headerTextColor: Colors.black54,
                  buttonText: "AI 상담 시작하기",
                  buttonColor: Colors.black,
                  buttonTextColor: Colors.white,
                  onButtonPressed: () {
                    print("AI 상담 시작하기");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AIScreen()),
                    );
                  },
                  additionalActions: [
                    ActionRow(
                      mainText: "AI와 대화 기록 보기",
                      actionText: "기록 확인",
                      onTap: () {
                        print("AI와 대화 기록 보기 (AIScreen으로 이동)");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AIScreen()),
                        );
                      },
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ExpandedSectionCard(
                  headerText: "나에게 맞는 상담사를 찾아요",
                  title: "상담사 매칭 하러 가기",
                  headerIcon: Icons.people_alt_outlined,
                  headerIconColor: Colors.black,
                  cardColor: Colors.white,
                  titleTextColor: Colors.black,
                  headerTextColor: Colors.black54,
                  buttonText: "상담사 매칭 시작",
                  buttonColor: Colors.black,
                  buttonTextColor: Colors.white,
                  onButtonPressed: () {
                    print("상담사 매칭 시작");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessageScreen(),
                      ),
                    );
                  },
                  additionalActions: [
                    ActionRow(
                      mainText: "상담사 프로필 둘러보기",
                      actionText: "프로필 확인",
                      onTap: () {
                        print("상담사 프로필 둘러보기 (MessageScreen으로 이동)");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageScreen(),
                          ),
                        );
                      },
                      textColor: Colors.black,
                    ),
                    Divider(color: Colors.black12, height: 20),
                    ActionRow(
                      mainText: "상담사 확인",
                      actionText: "상담사 확인 하러 가기",
                      onTap: () {
                        print("상담 예약 내역 확인 (MessageScreen으로 이동)");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageScreen(),
                          ),
                        );
                      },
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: ExpandedSectionCard(
                  headerText: "오늘 하루를 기록해요",
                  title: "일기 쓰러 가기",
                  headerIcon: Icons.book_outlined,
                  headerIconColor: Colors.black,
                  cardColor: Colors.white,
                  titleTextColor: Colors.black,
                  headerTextColor: Colors.black54,
                  buttonText: "새 일기 작성하기",
                  buttonColor: Colors.black,
                  buttonTextColor: Colors.white,
                  onButtonPressed: () {
                    print("새 일기 작성하기");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WriteScreen()),
                    );
                  },
                  additionalActions: [
                    ActionRow(
                      mainText: "나의 일기 모아보기",
                      actionText: "전체 보기",
                      onTap: () {
                        print("나의 일기 보러가기 (WriteScreen으로 이동)");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WriteScreen(),
                          ),
                        );
                      },
                      textColor: Colors.black,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
