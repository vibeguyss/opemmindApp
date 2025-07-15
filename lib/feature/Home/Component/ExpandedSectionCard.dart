import 'package:flutter/material.dart';
import 'package:openmind_app/shared/FontExt.dart'; // FontExt 경로에 따라 수정

class ExpandedSectionCard extends StatelessWidget {
  final String headerText;
  final String title;
  final IconData headerIcon;
  final Color headerIconColor;
  final Color cardColor;
  final Color titleTextColor;
  final Color headerTextColor;
  final String buttonText;
  final Color buttonColor;
  final Color buttonTextColor;
  final VoidCallback onButtonPressed;
  final List<Widget>? additionalActions;

  const ExpandedSectionCard({
    Key? key,
    required this.headerText,
    required this.title,
    required this.headerIcon,
    this.headerIconColor = const Color(0xFF90CAF9),
    this.cardColor = Colors.white,
    this.titleTextColor = Colors.black,
    this.headerTextColor = Colors.black54,
    required this.buttonText,
    this.buttonColor = Colors.black,
    this.buttonTextColor = Colors.white,
    required this.onButtonPressed,
    this.additionalActions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding:  EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headerText,
                  style: AppFont.regular(14).copyWith(color: headerTextColor),
                ),
                Icon(headerIcon, color: headerIconColor, size: 30),
              ],
            ),
             SizedBox(height: 5),
            Text(
              title,
              style: AppFont.bold(22).copyWith(color: titleTextColor),
            ),
             SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onButtonPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                  ),
                  child: Text(
                    buttonText,
                    style: AppFont.bold(18).copyWith(color: buttonTextColor),
                  ),
                ),
              ),
            ),
            // THIS PART IS MISSING!
            if (additionalActions != null && additionalActions!.isNotEmpty) ...[
              const SizedBox(height: 20),
              ...additionalActions!,
            ],
          ],
        ),
      ),
    );
  }
}

class ActionRow extends StatelessWidget {
  final String mainText;
  final String actionText;
  final VoidCallback onTap;
  final Color textColor;

  const ActionRow({
    Key? key,
    required this.mainText,
    required this.actionText,
    required this.onTap,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mainText,
              style: AppFont.medium(16).copyWith(color: textColor),
            ),
            Row(
              children: [
                Text(
                  actionText,
                  style: AppFont.medium(
                    16,
                  ).copyWith(color: textColor.withOpacity(0.54)),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  color: textColor.withOpacity(0.54),
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
