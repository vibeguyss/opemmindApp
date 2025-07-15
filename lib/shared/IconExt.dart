import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcon {
  home('home'),
  write('write'),
  message('message'),
  profile('profile'),
  bell('bell'),
  search('search');

  final String baseName;

  const AppIcon(this.baseName);
}

extension AppIconExtension on AppIcon {
  Widget toIcon({
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    Color? color,
  }) {
    final iconPath = 'assets/icons/${baseName}.svg';
    return SvgPicture.asset(
      iconPath,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }
}
