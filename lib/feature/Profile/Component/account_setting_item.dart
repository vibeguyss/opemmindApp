import 'package:flutter/material.dart';
import 'package:openmind_app/shared/FontExt.dart';

class AccountSettingItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const AccountSettingItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isDestructive ? Colors.red : Colors.black;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: (AppFont.medium(16, color: textColor))),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
          ],
        ),
      ),
    );
  }
}
