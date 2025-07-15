import 'package:flutter/material.dart';
import 'package:openmind_app/shared/ColorExt.dart';
import 'package:openmind_app/shared/FontExt.dart';
import 'package:openmind_app/shared/IconExt.dart';

class TabItem extends StatelessWidget {
  final AppIcon icon;
  final bool isSelected;
  final VoidCallback onTap;
  final String description;

  const TabItem({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon.toIcon(
                color: isSelected ? Colors.black : AppColor.disable,
                width: 28,
                height: 25,
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: AppFont.regular(
                  10,
                  color: isSelected ? Colors.black : AppColor.disable,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
