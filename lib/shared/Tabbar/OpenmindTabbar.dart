import 'package:flutter/material.dart';
import 'package:openmind_app/shared/IconExt.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:openmind_app/shared/Tabbar/TabItem.dart';

class OpenmindTabbar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback? onAITap;

  const OpenmindTabbar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.onAITap,
  }) : super(key: key);

  @override
  _OpenmindTabbarState createState() => _OpenmindTabbarState();
}

class _OpenmindTabbarState extends State<OpenmindTabbar>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _pulseController;

  late Animation<double> _floatingAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _floatingController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _floatingAnimation = Tween<double>(begin: -1.5, end: 1.5).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );

    _pulseController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      (icon: AppIcon.home, label: "홈"),
      (icon: AppIcon.search, label: "둘러보기"),
      (icon: AppIcon.write, label: "일기"),
      (icon: AppIcon.profile, label: "프로필"),
    ];

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 60,
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                TabItem(
                  icon: tabItems[0].icon,
                  isSelected: widget.currentIndex == 0,
                  onTap: () => widget.onTap(0),
                  description: tabItems[0].label,
                ),
                TabItem(
                  icon: tabItems[1].icon,
                  isSelected: widget.currentIndex == 1,
                  onTap: () => widget.onTap(1),
                  description: tabItems[1].label,
                ),
                Expanded(child: SizedBox()),
                TabItem(
                  icon: tabItems[2].icon,
                  isSelected: widget.currentIndex == 2,
                  onTap: () => widget.onTap(2),
                  description: tabItems[2].label,
                ),
                TabItem(
                  icon: tabItems[3].icon,
                  isSelected: widget.currentIndex == 3,
                  onTap: () => widget.onTap(3),
                  description: tabItems[3].label,
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([_floatingAnimation, _pulseAnimation]),
            builder: (context, child) {
              return Positioned(
                top: -10 + _floatingAnimation.value,
                left: MediaQuery.of(context).size.width / 2 - 35,
                child: Transform.scale(
                  scale: _pulseAnimation.value,
                  child: GestureDetector(
                    onTap: widget.onAITap,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.main.withOpacity(0.3),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                          // 고정된 글로우 효과
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.grey[100]!, AppColor.main],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "AI 상담",
                            style: AppFont.bold(13, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
