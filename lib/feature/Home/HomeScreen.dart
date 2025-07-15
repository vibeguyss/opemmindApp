import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:openmind_app/feature/AI/AIScreen.dart';
import 'package:openmind_app/feature/Arround/ArroundScreen.dart';
import 'package:openmind_app/feature/Component/SearchTextField.dart';
import 'package:openmind_app/feature/Home/Component/ExpandedSectionCard.dart';
import 'package:openmind_app/feature/Message/MessageScreen.dart';
import 'package:openmind_app/feature/Write/WriteScreen.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';

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
    final cardRadius = 14.0;
    final buttonHeight = 44.0;
    final mainColor = AppColor.main;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.background,
            centerTitle: false,
            title: Text("OPENMIND", style: AppFont.bold(20)),
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MessageScreen()),
                  );
                },
                icon: Icon(Icons.send, color: Colors.black87),
                splashRadius: 20,
              ),
            ],
          ),

          CupertinoSliverRefreshControl(
            onRefresh: () async {
              // 리프레시 기능 추가 가능
              print("스크롤 리프레시");
            },
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                height: 40,
                child: SearchTextField(
                  controller: _controller,
                  onChanged: (value) {
                    setState(() => _searchText = value);
                  },
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              // AI 상담 카드
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(cardRadius),
                  ),
                  shadowColor: Colors.black12,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: mainColor.withOpacity(0.1),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.psychology_outlined,
                                size: 32,
                                color: mainColor,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "AI에게 다 털어놔요",
                              style: AppFont.bold(
                                16,
                              ).copyWith(color: mainColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "AI랑 상담하러 가기",
                          style: AppFont.bold(
                            22,
                          ).copyWith(color: Colors.black87, height: 1.1),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "마음의 무게를 가볍게, AI가 함께 합니다.",
                          style: AppFont.regular(
                            14,
                          ).copyWith(color: Colors.black54),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => AIScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                            ),
                            child: Text(
                              "AI 상담 시작하기",
                              style: AppFont.bold(
                                16,
                              ).copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 상담사 매칭 카드
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: ExpandedSectionCard(
                  headerText: "나에게 맞는 상담사를 찾아요",
                  title: "상담사 매칭 진행 중이에요",
                  headerIcon: Icons.people_alt_outlined,
                  headerIconColor: Colors.black87,
                  cardColor: Colors.white,
                  titleTextColor: Colors.black87,
                  headerTextColor: Colors.black54,
                  buttonText: "나의 상담사 보기",
                  buttonColor: mainColor,
                  buttonTextColor: Colors.white,
                  onButtonPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ArroundScreen()),
                    );
                  },
                  additionalActions: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "87%의 사용자들이 연결되었어요",
                            style: AppFont.medium(
                              13,
                            ).copyWith(color: Colors.black54),
                          ),
                          Text(
                            "87%",
                            style: AppFont.bold(
                              13,
                            ).copyWith(color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: 0.87,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 20),

                    ActionRow(
                      mainText: "상담사 프로필 둘러보기",
                      actionText: "프로필 확인",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ArroundScreen()),
                        );
                      },
                      textColor: Colors.black87,
                    ),
                    const Divider(color: Colors.black12, height: 20),
                    ActionRow(
                      mainText: "상담사 예약 확인",
                      actionText: "예약 내역 보기",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => MessageScreen()),
                        );
                      },
                      textColor: Colors.black87,
                    ),
                  ],
                ),
              ),

              // 일기 작성 카드
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: ExpandedSectionCard(
                  headerText: "오늘 하루를 기록해요",
                  title: "일기 쓰러 가기",
                  headerIcon: Icons.book_outlined,
                  headerIconColor: Colors.black87,
                  cardColor: Colors.white,
                  titleTextColor: Colors.black87,
                  headerTextColor: Colors.black54,
                  buttonText: "새 일기 작성하기",
                  buttonColor: mainColor,
                  buttonTextColor: Colors.white,
                  onButtonPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => WriteScreen()),
                    );
                  },
                  additionalActions: [
                    ActionRow(
                      mainText: "나의 일기 모아보기",
                      actionText: "전체 보기",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => WriteScreen()),
                        );
                      },
                      textColor: Colors.black87,
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
