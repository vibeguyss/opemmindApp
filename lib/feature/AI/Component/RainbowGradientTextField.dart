import 'package:flutter/material.dart';
import 'package:openmind_app/shared/ColorExt.dart';

class RainbowGradientTextField extends StatelessWidget {
  final TextEditingController controller;
  final Animation<double> animation;
  final ValueChanged<String>? onSubmitted;

  const RainbowGradientTextField({
    Key? key,
    required this.controller,
    required this.animation,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppColor.aiGradient1,
      AppColor.aiGradient2,
      AppColor.aiGradient3,
      AppColor.aiGradient4,
      AppColor.aiGradient5,
      AppColor.aiGradient6,
      AppColor.aiGradient7,
    ];

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final gradient = SweepGradient(
          colors: colors,
          startAngle: animation.value * 2 * 3.14159,
          endAngle: (animation.value + 1) * 2 * 3.14159,
          tileMode: TileMode.repeated,
        );

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: gradient,
            boxShadow: [
              BoxShadow(
                color: AppColor.main.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(2),
          child: TextField(
            controller: controller,
            minLines: 1,
            maxLines: 5,
            style: const TextStyle(color: Colors.black87, fontSize: 16),
            cursorColor: AppColor.main,
            decoration: InputDecoration(
              hintText: "메시지 보내기...",
              hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
              filled: true,
              fillColor: AppColor.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            textInputAction: TextInputAction.send,
            onSubmitted: onSubmitted,
          ),
        );
      },
    );
  }
}

